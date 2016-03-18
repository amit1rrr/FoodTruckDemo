# rake db:seed
# This destroys all the records in the FoodTrucks table and fills it up again 
# by calling the SODA api. It essentially refreshes data in our backend.

FoodTruck.destroy_all
GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

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