require 'test_helper'

class SectionenrollmentsControllerTest < ActionController::TestCase
  setup do
    @sectionenrollment = sectionenrollments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sectionenrollments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sectionenrollment" do
    assert_difference('Sectionenrollment.count') do
      post :create, sectionenrollment: @sectionenrollment.attributes
    end

    assert_redirected_to sectionenrollment_path(assigns(:sectionenrollment))
  end

  test "should show sectionenrollment" do
    get :show, id: @sectionenrollment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sectionenrollment.to_param
    assert_response :success
  end

  test "should update sectionenrollment" do
    put :update, id: @sectionenrollment.to_param, sectionenrollment: @sectionenrollment.attributes
    assert_redirected_to sectionenrollment_path(assigns(:sectionenrollment))
  end

  test "should destroy sectionenrollment" do
    assert_difference('Sectionenrollment.count', -1) do
      delete :destroy, id: @sectionenrollment.to_param
    end

    assert_redirected_to sectionenrollments_path
  end
end
