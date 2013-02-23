require 'test_helper'

class NewhirecredentialsControllerTest < ActionController::TestCase
  setup do
    @newhirecredential = newhirecredentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newhirecredentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newhirecredential" do
    assert_difference('Newhirecredential.count') do
      post :create, newhirecredential: @newhirecredential.attributes
    end

    assert_redirected_to newhirecredential_path(assigns(:newhirecredential))
  end

  test "should show newhirecredential" do
    get :show, id: @newhirecredential.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newhirecredential.to_param
    assert_response :success
  end

  test "should update newhirecredential" do
    put :update, id: @newhirecredential.to_param, newhirecredential: @newhirecredential.attributes
    assert_redirected_to newhirecredential_path(assigns(:newhirecredential))
  end

  test "should destroy newhirecredential" do
    assert_difference('Newhirecredential.count', -1) do
      delete :destroy, id: @newhirecredential.to_param
    end

    assert_redirected_to newhirecredentials_path
  end
end
