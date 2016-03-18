class FoodTruck < ActiveRecord::Base
  RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
    # Use a geographic implementation for point columns.
    config.register(RGeo::Geographic.spherical_factory(srid: 4326), geo_type: "st_point", sql_type: "geography")
  end

  # SF OpenData don't have rating for food trucks. We give random ratings for display purposes.
  def rating
    rand(40..140).to_s
  end

  scope :with_food_items, -> (keyword) { where("food_items LIKE '%' || '#{keyword}' || '%'") }
  scope :order_by_distance, -> (latitude, longitude) { order("ST_Distance(location,  'POINT(#{longitude} #{latitude})')") }
  scope :within_radius, -> (latitude, longitude, range) { where("ST_DWithin(location, 'POINT(#{longitude} #{latitude})', #{range})") }

  def self.filter full_address, search_keywords, range, limit
    lat, long = Geocoder.coordinates(full_address)
    range_in_meters = range*1000
    FoodTruck.within_radius(lat, long, range_in_meters).with_food_items(search_keywords).order_by_distance(lat, long).limit(limit)
  end
end