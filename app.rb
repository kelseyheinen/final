# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

locations_table = DB.from(:locations)
users_table = DB.from(:users)
reports_table = DB.from(:reports)
ratings_table = DB.from(:ratings)
flavors_table = DB.from(:flavors)

before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

get "/" do
    view "new_login"
end

post "/logins/create" do
    user = users_table.where(email: params["email"]).to_a[0]
    if 
        user && BCrypt::Password::new(user[:password]) == params["password"]
        session["user_id"] = user[:id]
        @current_user = user
        view "create_login"
    else
        view "create_login_failed"
    end
end

get "/new_user" do
    view "new_user"
end

post "/users/create" do
    puts params
    hashed_password = BCrypt::Password.create(params["password"])
    users_table.insert(email: params["email"], password: hashed_password)
    view "create_user"
end

get "/logout" do
    session["user_id"] = nil
    @current_user = nil
    view "logout"
end

get "/locations" do
    puts locations_table.all
    @locations = locations_table.all.to_a
    view "locations"
end

get "/locations/:id" do
    @location = locations_table.where(id: params[:id]).to_a[0]
    
    # goes in the view
    @uniqueflavorids = ratings_table.where(location_id: params[:id], active: true).distinct.select(:flavor_id)
    @flavornames = flavors_table
    @ratingsbystore = ratings_table
    # 1. loop through ids
    # 2. for each id in the loop
        # 2a. calculate average of ratings for that location and flavor id
            # ratings_table.where(location_id: @location[:id]).where(flavor_id: flavor_id).average(:rating)

        # 2b. find the flavor's name by the id
             # flavors table  query name by id

# #get unique list of flavor ids from ratings table where location id = params[:id] 
    @uniqueflavorids = ratings_table.where(location_id: params[:id], active: true).distinct.select(:flavor_id)
# #define varaible 
#     @flavors = ratings_table.where(ids = @uniqueflavorids).to_a
# #create average vaiable
#     #get flavor ID from list generated in loop on flavors.erb
#     @avgratings=ratings_table average(ratings) where flavor id = ^

    view "flavors"
end

get "/new_check_in" do
    view "new_check_in"
end

post "/check_in" do
    ratings_table.insert(flavor_id: params["flavor"],
                        location_id: params["location"],
                        rating: params["rating"],
                        user_id: session["user_id"],
                        active: true)
    view "create_check_in"
end

get "/new_report" do
    view "new_report"
end

post "/report/create" do
    reports_table.insert(flavor: params["flavor"],
                        location_id: params["location"],
                        status: params["status"])
    account_sid = ENV["AC16c32757e27a5c93cc6ea55b6fc855f9"]
    auth_token = ENV["7ebc2c2568d4b9f3f24a2c15109113a9"]
    client = Twilio::REST::Client.new(account_sid, auth_token)
    client.messages.create(
        from: "+12055765636", 
        to: "+14408230448",
        body: "You have a new Jeni's Flavor Finder report.")
    view "create_report"
end