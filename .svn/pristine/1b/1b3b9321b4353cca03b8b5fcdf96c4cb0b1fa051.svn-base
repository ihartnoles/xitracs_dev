require 'test_helper'

class FacultycredentialsControllerTest < ActionController::TestCase
  setup do
    @facultycredential = facultycredentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facultycredentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facultycredential" do
    assert_difference('Facultycredential.count') do
      post :create, facultycredential: @facultycredential.attributes
    end

    assert_redirected_to facultycredential_path(assigns(:facultycredential))
  end

  test "should show facultycredential" do
    get :show, id: @facultycredential.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facultycredential.to_param
    assert_response :success
  end

  test "should update facultycredential" do
    put :update, id: @facultycredential.to_param, facultycredential: @facultycredential.attributes
    assert_redirected_to facultycredential_path(assigns(:facultycredential))
  end

  test "should destroy facultycredential" do
    assert_difference('Facultycredential.count', -1) do
      delete :destroy, id: @facultycredential.to_param
    end

    assert_redirected_to facultycredentials_path
  end
end
