require 'test_helper'

class FoodTrucksControllerTest < ActionController::TestCase
  setup do
    @food_truck = food_trucks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:food_trucks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food_truck" do
    assert_difference('FoodTruck.count') do
      post :create, food_truck: { address: @food_truck.address, food_items: @food_truck.food_items, location: @food_truck.location, name: @food_truck.name, object_id: @food_truck.object_id, time_slots: @food_truck.time_slots, vehicle_type: @food_truck.vehicle_type }
    end

    assert_redirected_to food_truck_path(assigns(:food_truck))
  end

  test "should show food_truck" do
    get :show, id: @food_truck
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food_truck
    assert_response :success
  end

  test "should update food_truck" do
    patch :update, id: @food_truck, food_truck: { address: @food_truck.address, food_items: @food_truck.food_items, location: @food_truck.location, name: @food_truck.name, object_id: @food_truck.object_id, time_slots: @food_truck.time_slots, vehicle_type: @food_truck.vehicle_type }
    assert_redirected_to food_truck_path(assigns(:food_truck))
  end

  test "should destroy food_truck" do
    assert_difference('FoodTruck.count', -1) do
      delete :destroy, id: @food_truck
    end

    assert_redirected_to food_trucks_path
  end
end
