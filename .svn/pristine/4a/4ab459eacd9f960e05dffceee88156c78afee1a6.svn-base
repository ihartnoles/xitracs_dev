require 'test_helper'

class KeyvaluesControllerTest < ActionController::TestCase
  setup do
    @keyvalue = keyvalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyvalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyvalue" do
    assert_difference('Keyvalue.count') do
      post :create, keyvalue: @keyvalue.attributes
    end

    assert_redirected_to keyvalue_path(assigns(:keyvalue))
  end

  test "should show keyvalue" do
    get :show, id: @keyvalue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyvalue.to_param
    assert_response :success
  end

  test "should update keyvalue" do
    put :update, id: @keyvalue.to_param, keyvalue: @keyvalue.attributes
    assert_redirected_to keyvalue_path(assigns(:keyvalue))
  end

  test "should destroy keyvalue" do
    assert_difference('Keyvalue.count', -1) do
      delete :destroy, id: @keyvalue.to_param
    end

    assert_redirected_to keyvalues_path
  end
end
