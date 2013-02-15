require 'test_helper'

class QualificationreasonsControllerTest < ActionController::TestCase
  setup do
    @qualificationreason = qualificationreasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qualificationreasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qualificationreason" do
    assert_difference('Qualificationreason.count') do
      post :create, qualificationreason: @qualificationreason.attributes
    end

    assert_redirected_to qualificationreason_path(assigns(:qualificationreason))
  end

  test "should show qualificationreason" do
    get :show, id: @qualificationreason.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qualificationreason.to_param
    assert_response :success
  end

  test "should update qualificationreason" do
    put :update, id: @qualificationreason.to_param, qualificationreason: @qualificationreason.attributes
    assert_redirected_to qualificationreason_path(assigns(:qualificationreason))
  end

  test "should destroy qualificationreason" do
    assert_difference('Qualificationreason.count', -1) do
      delete :destroy, id: @qualificationreason.to_param
    end

    assert_redirected_to qualificationreasons_path
  end
end
