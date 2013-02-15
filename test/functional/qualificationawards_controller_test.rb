require 'test_helper'

class QualificationawardsControllerTest < ActionController::TestCase
  setup do
    @qualificationaward = qualificationawards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qualificationawards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qualificationaward" do
    assert_difference('Qualificationaward.count') do
      post :create, qualificationaward: @qualificationaward.attributes
    end

    assert_redirected_to qualificationaward_path(assigns(:qualificationaward))
  end

  test "should show qualificationaward" do
    get :show, id: @qualificationaward.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qualificationaward.to_param
    assert_response :success
  end

  test "should update qualificationaward" do
    put :update, id: @qualificationaward.to_param, qualificationaward: @qualificationaward.attributes
    assert_redirected_to qualificationaward_path(assigns(:qualificationaward))
  end

  test "should destroy qualificationaward" do
    assert_difference('Qualificationaward.count', -1) do
      delete :destroy, id: @qualificationaward.to_param
    end

    assert_redirected_to qualificationawards_path
  end
end
