# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :locations do
  primary_key :id
  String :store_name
  String :latitude
  String :longitude

end

DB.create_table! :users do
  primary_key :id
  String :email
  String :password
end

DB.create_table! :reports do
  primary_key :id
  String :flavor
  foreign_key :location_id
  String :status, text: true
end

DB.create_table! :ratings do
  primary_key :id
  foreign_key :flavor_id
  foreign_key :user_id
  Integer :rating
  foreign_key :location_id
  Boolean :active
end

DB.create_table! :flavors do
  primary_key :id
  String :flavor, text: true
end


# Insert initial (seed) data for locations
locations_table = DB.from(:locations)
flavors_table = DB.from(:flavors)
ratings_table = DB.from(:ratings)

locations_table.insert(id:1,
                        store_name: "Southport",
                        latitude: 41.94366,
                        longitude: -87.67288)
locations_table.insert(id:2,
                        store_name: "Wicker Park",
                        latitude: 41.90894,
                        longitude:-87.68355)
locations_table.insert(id:3,
                        store_name: "Armitage",
                        latitude: 41.91824,
                        longitude: -87.65340)
locations_table.insert(id:4,
                        store_name: "North Wells",
                        latitude:41.90812,
                        longitude:-87.63666)
#Insert Seed Data for flavors 
flavors_table.insert(id: 1, 
                    flavor: "Brambelberry Crisp") 
flavors_table.insert(id: 2,
                    flavor: "Salted Peanut Butter with Chocolate Flecks")
flavors_table.insert(id: 3, 
                    flavor: "Wildberry Lavender") 
flavors_table.insert(id: 4, 
                    flavor: "Cream Puff")
flavors_table.insert(id: 5, 
                    flavor: "Black Cat Espresso")
flavors_table.insert(id: 6, 
                    flavor: "Churro")
flavors_table.insert(id: 7, 
                    flavor: "Pistachio & Honey")

# Insert Seed Data for ratings
ratings_table.insert(id: 1, 
                        flavor_id: 1,
                        user_id: 1,
                        rating: 8,
                        location_id:1, 
                        active: true) 

ratings_table.insert(id: 2, 
                        flavor_id: 1,
                        user_id: 1,
                        rating: 8,
                        location_id:2,
                        active: true) 
 
ratings_table.insert(id: 3, 
                        flavor_id: 1,
                        user_id: 1,
                        rating: 8,
                        location_id:3, 
                        active: true)

ratings_table.insert(id: 4, 
                        flavor_id: 1,
                        user_id: 1,
                        rating: 8,
                        location_id:4, 
                        active: true)

ratings_table.insert(id: 5, 
                        flavor_id: 2,
                        user_id: 1,
                        rating: 7,
                        location_id:1,
                        active: true) 

ratings_table.insert(id: 6,  
                        flavor_id: 2,
                        user_id: 1,
                        rating: 7,
                        location_id:2, 
                        active: true) 
 
ratings_table.insert(id: 7, 
                        flavor_id: 2,
                        user_id: 1,
                        rating: 7,
                        location_id:3, 
                        active: true)

ratings_table.insert(id: 8, 
                        flavor_id: 2,
                        user_id: 1,
                        rating: 7,
                        location_id:4, 
                        active: true)

ratings_table.insert(id: 9, 
                        flavor_id: 3,
                        user_id: 1,
                        rating: 8,
                        location_id:1,
                        active: true) 

ratings_table.insert(id: 10, 
                        flavor_id: 3,
                        user_id: 1,
                        rating: 8,
                        location_id:2,
                        active: true) 
 
ratings_table.insert(id: 11, 
                        flavor_id: 3,
                        user_id: 1,
                        rating: 8,
                        location_id:3, 
                        active: true)

ratings_table.insert(id: 12, 
                        flavor_id: 3,
                        user_id: 1,
                        rating: 8,
                        location_id:4, 
                        active: true)

ratings_table.insert(id: 13, 
                        flavor_id: 4,
                        user_id: 1,
                        rating: 10,
                        location_id:1, 
                        active: true) 

ratings_table.insert(id: 14, 
                        flavor_id: 5,
                        user_id: 1,
                        rating: 7,
                        location_id:2, 
                        active: true) 
 
ratings_table.insert(id: 15, 
                        flavor_id: 6,
                        user_id: 1,
                        rating: 9,
                        location_id:3, 
                        active: true)

ratings_table.insert(id: 16, 
                        flavor_id: 7,
                        user_id: 1,
                        rating: 10,
                        location_id:4,
                        active: true)
                        