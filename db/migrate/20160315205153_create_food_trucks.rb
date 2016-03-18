class CreateFoodTrucks < ActiveRecord::Migration
  def change
    create_table :food_trucks do |t|
      t.string :name
      t.string :vehicle_type
      t.string :food_items
      t.string :time_slots
      t.string :address
      t.st_point :location, geographic: true
      t.integer :object_id

      t.timestamps null: false
    end
  end
end
