require 'test_helper'

class SectioncredentialsControllerTest < ActionController::TestCase
  setup do
    @sectioncredential = sectioncredentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sectioncredentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sectioncredential" do
    assert_difference('Sectioncredential.count') do
      post :create, sectioncredential: @sectioncredential.attributes
    end

    assert_redirected_to sectioncredential_path(assigns(:sectioncredential))
  end

  test "should show sectioncredential" do
    get :show, id: @sectioncredential.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sectioncredential.to_param
    assert_response :success
  end

  test "should update sectioncredential" do
    put :update, id: @sectioncredential.to_param, sectioncredential: @sectioncredential.attributes
    assert_redirected_to sectioncredential_path(assigns(:sectioncredential))
  end

  test "should destroy sectioncredential" do
    assert_difference('Sectioncredential.count', -1) do
      delete :destroy, id: @sectioncredential.to_param
    end

    assert_redirected_to sectioncredentials_path
  end
end
