require 'test_helper'

class PurposesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purposes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purpose" do
    assert_difference('Purpose.count') do
      post :create, :purpose => { }
    end

    assert_redirected_to purpose_path(assigns(:purpose))
  end

  test "should show purpose" do
    get :show, :id => purposes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => purposes(:one).to_param
    assert_response :success
  end

  test "should update purpose" do
    put :update, :id => purposes(:one).to_param, :purpose => { }
    assert_redirected_to purpose_path(assigns(:purpose))
  end

  test "should destroy purpose" do
    assert_difference('Purpose.count', -1) do
      delete :destroy, :id => purposes(:one).to_param
    end

    assert_redirected_to purposes_path
  end
end
