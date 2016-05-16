require 'test_helper'

class ChassesControllerTest < ActionController::TestCase
  setup do
    @chass = chasses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chasses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chass" do
    assert_difference('Chassis.count') do
      post :create, chass: { chassisnum: @chass.chassisnum, msale_detail_id: @chass.msale_detail_id, msale_id: @chass.msale_id }
    end

    assert_redirected_to chass_path(assigns(:chass))
  end

  test "should show chass" do
    get :show, id: @chass
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chass
    assert_response :success
  end

  test "should update chass" do
    patch :update, id: @chass, chass: { chassisnum: @chass.chassisnum, msale_detail_id: @chass.msale_detail_id, msale_id: @chass.msale_id }
    assert_redirected_to chass_path(assigns(:chass))
  end

  test "should destroy chass" do
    assert_difference('Chassis.count', -1) do
      delete :destroy, id: @chass
    end

    assert_redirected_to chasses_path
  end
end
