json.array!(@food_trucks) do |food_truck|
  json.extract! food_truck, :id, :name, :vehicle_type, :food_items, :time_slots, :address, :location, :object_id
  json.url food_truck_url(food_truck, format: :json)
end
