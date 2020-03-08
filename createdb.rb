# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :locations do
  primary_key :id
  String :store_name
  Numeric :latitude
  Numeric :longitude

end

DB.create_table! :users do
  primary_key :id
  String :email
  String :password
end

DB.create_table! :reports do
  primary_key :id
  String :flavor
  String :location
  String :status, text: true
end

DB.create_table! :flavors do
  primary_key :id
  String :flavor
  foreign_key :user_id
  Integer :rating
  foreign_key :location_id
  Boolean :active
end

# Insert initial (seed) data
locations_table = DB.from(:locations)
flavors_table = DB.from(:flavors)

locations_table.insert(id:1,
                        store_name: "Southport",
                        latitude: 41.9436608,
                        longitude: -87.6728859)
locations_table.insert(id:2,
                        store_name: "Wicker Park",
                        latitude: 41.9089493,
                        longitude:-87.6835551)
locations_table.insert(id:3,
                        store_name: "Armitage",
                        latitude: 41.9182499,
                        longitude: -87.6534092)
locations_table.insert(id:4,
                        store_name: "North Wells",
                        latitude:41.9081266 ,
                        longitude:-87.6366676)

# Insert Seed Data
flavors_table.insert(id: 1, 
                        flavor: "Brambelberry Crisp",
                        user_id: 1,
                        rating: nil,
                        location_id:1, 
                        active: true) 

flavors_table.insert(id: 2, 
                        flavor: "Brambelberry Crisp",
                        user_id: 1,
                        rating: nil,
                        location_id:2, 
                        active: true) 
 
flavors_table.insert(id: 3, 
                        flavor: "Brambelberry Crisp",
                        user_id: 1,
                        rating: nil,
                        location_id:3, 
                        active: true)

flavors_table.insert(id: 4, 
                        flavor: "Brambelberry Crisp",
                        user_id: 1,
                        rating: nil,
                        location_id:4, 
                        active: true)

flavors_table.insert(id: 5, 
                        flavor: "Salted Peanut Butter with Chocolate Flecks",
                        user_id: 1,
                        rating: nil,
                        location_id:1, 
                        active: true) 

flavors_table.insert(id: 6, 
                        flavor: "Salted Peanut Butter with Chocolate Flecks",
                        user_id: 1,
                        rating: nil,
                        location_id:2, 
                        active: true) 
 
flavors_table.insert(id: 7, 
                        flavor: "Salted Peanut Butter with Chocolate Flecks",
                        user_id: 1,
                        rating: nil,
                        location_id:3, 
                        active: true)

flavors_table.insert(id: 8, 
                        flavor: "Salted Peanut Butter with Chocolate Flecks",
                        user_id: 1,
                        rating: nil,
                        location_id:4, 
                        active: true)

flavors_table.insert(id: 9, 
                        flavor: "Wildberry Lavender",
                        user_id: 1,
                        rating: nil,
                        location_id:1, 
                        active: true) 

flavors_table.insert(id: 10, 
                        flavor: "Wildberry Lavender",
                        user_id: 1,
                        rating: nil,
                        location_id:2, 
                        active: true) 
 
flavors_table.insert(id: 11, 
                        flavor: "Wildberry Lavender",
                        user_id: 1,
                        rating: nil,
                        location_id:3, 
                        active: true)

flavors_table.insert(id: 12, 
                        flavor: "Wildberry Lavender",
                        user_id: 1,
                        rating: nil,
                        location_id:4, 
                        active: true)

flavors_table.insert(id: 13, 
                        flavor: "Cream Puff",
                        user_id: 1,
                        rating: nil,
                        location_id:1, 
                        active: true) 

flavors_table.insert(id: 14, 
                        flavor: "Black Cat Espresso",
                        user_id: 1,
                        rating: nil,
                        location_id:2, 
                        active: true) 
 
flavors_table.insert(id: 15, 
                        flavor: "Churro",
                        user_id: 1,
                        rating: nil,
                        location_id:3, 
                        active: true)

flavors_table.insert(id: 16, 
                        flavor: "Pistachio & Honey",
                        user_id: 1,
                        rating: nil,
                        location_id:4, 
                        active: true)
                        