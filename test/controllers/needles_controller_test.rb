require 'test_helper'

class NeedlesControllerTest < ActionController::TestCase
  setup do
    @needle = needles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:needles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create needle" do
    assert_difference('Needle.count') do
      post :create, needle: { category: @needle.category, machine_id: @needle.machine_id, model: @needle.model, price: @needle.price, qty: @needle.qty, size: @needle.size, stock: @needle.stock }
    end

    assert_redirected_to needle_path(assigns(:needle))
  end

  test "should show needle" do
    get :show, id: @needle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @needle
    assert_response :success
  end

  test "should update needle" do
    patch :update, id: @needle, needle: { category: @needle.category, machine_id: @needle.machine_id, model: @needle.model, price: @needle.price, qty: @needle.qty, size: @needle.size, stock: @needle.stock }
    assert_redirected_to needle_path(assigns(:needle))
  end

  test "should destroy needle" do
    assert_difference('Needle.count', -1) do
      delete :destroy, id: @needle
    end

    assert_redirected_to needles_path
  end
end
