require 'test_helper'

class TenurestatusesControllerTest < ActionController::TestCase
  setup do
    @tenurestatus = tenurestatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tenurestatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tenurestatus" do
    assert_difference('Tenurestatus.count') do
      post :create, tenurestatus: @tenurestatus.attributes
    end

    assert_redirected_to tenurestatus_path(assigns(:tenurestatus))
  end

  test "should show tenurestatus" do
    get :show, id: @tenurestatus.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tenurestatus.to_param
    assert_response :success
  end

  test "should update tenurestatus" do
    put :update, id: @tenurestatus.to_param, tenurestatus: @tenurestatus.attributes
    assert_redirected_to tenurestatus_path(assigns(:tenurestatus))
  end

  test "should destroy tenurestatus" do
    assert_difference('Tenurestatus.count', -1) do
      delete :destroy, id: @tenurestatus.to_param
    end

    assert_redirected_to tenurestatuses_path
  end
end
