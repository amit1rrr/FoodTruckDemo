class AddSpatialIndexToFoodTrucks < ActiveRecord::Migration
  def change
    change_table :food_trucks do |t|
      t.index :location, using: :gist
    end
  end
end
