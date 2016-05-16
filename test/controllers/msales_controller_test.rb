require 'test_helper'

class MsalesControllerTest < ActionController::TestCase
  setup do
    @msale = msales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:msales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create msale" do
    assert_difference('Msale.count') do
      post :create, msale: { address: @msale.address, customer: @msale.customer, debt: @msale.debt, nic: @msale.nic, phone: @msale.phone, proforma: @msale.proforma, tax: @msale.tax, total: @msale.total }
    end

    assert_redirected_to msale_path(assigns(:msale))
  end

  test "should show msale" do
    get :show, id: @msale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @msale
    assert_response :success
  end

  test "should update msale" do
    patch :update, id: @msale, msale: { address: @msale.address, customer: @msale.customer, debt: @msale.debt, nic: @msale.nic, phone: @msale.phone, proforma: @msale.proforma, tax: @msale.tax, total: @msale.total }
    assert_redirected_to msale_path(assigns(:msale))
  end

  test "should destroy msale" do
    assert_difference('Msale.count', -1) do
      delete :destroy, id: @msale
    end

    assert_redirected_to msales_path
  end
end
