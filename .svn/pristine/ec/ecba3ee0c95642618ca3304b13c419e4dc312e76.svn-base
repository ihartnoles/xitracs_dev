require 'test_helper'

class EmploymentstatusesControllerTest < ActionController::TestCase
  setup do
    @employmentstatus = employmentstatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employmentstatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employmentstatus" do
    assert_difference('Employmentstatus.count') do
      post :create, employmentstatus: @employmentstatus.attributes
    end

    assert_redirected_to employmentstatus_path(assigns(:employmentstatus))
  end

  test "should show employmentstatus" do
    get :show, id: @employmentstatus.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employmentstatus.to_param
    assert_response :success
  end

  test "should update employmentstatus" do
    put :update, id: @employmentstatus.to_param, employmentstatus: @employmentstatus.attributes
    assert_redirected_to employmentstatus_path(assigns(:employmentstatus))
  end

  test "should destroy employmentstatus" do
    assert_difference('Employmentstatus.count', -1) do
      delete :destroy, id: @employmentstatus.to_param
    end

    assert_redirected_to employmentstatuses_path
  end
end
