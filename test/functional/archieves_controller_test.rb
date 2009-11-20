require 'test_helper'

class ArchievesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:archieves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create archiefe" do
    assert_difference('Archiefe.count') do
      post :create, :archiefe => { }
    end

    assert_redirected_to archiefe_path(assigns(:archiefe))
  end

  test "should show archiefe" do
    get :show, :id => archieves(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => archieves(:one).to_param
    assert_response :success
  end

  test "should update archiefe" do
    put :update, :id => archieves(:one).to_param, :archiefe => { }
    assert_redirected_to archiefe_path(assigns(:archiefe))
  end

  test "should destroy archiefe" do
    assert_difference('Archiefe.count', -1) do
      delete :destroy, :id => archieves(:one).to_param
    end

    assert_redirected_to archieves_path
  end
end
