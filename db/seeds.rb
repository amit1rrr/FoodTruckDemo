# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)
FoodTruck.destroy_all

client = SODA::Client.new({:domain => "data.sfgov.org", :app_token => "8unlbsQtQiz7mUS8d9IQ3KqGA"})
responses = client.get("rqzj-sfat", {:status => "APPROVED"})

responses.each do |row| 
  ft = FoodTruck.new
  ft.name = row.applicant
  ft.vehicle_type = row.facilitytype
  ft.food_items = row.fooditems
  ft.time_slots = row.dayshours
  ft.address = row.address
  ft.location = GEO_FACTORY.point(row.location.longitude, row.location.latitude) rescue next
  ft.save!
end