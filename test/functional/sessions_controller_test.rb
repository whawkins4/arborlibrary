require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    will = users(:one)
    post :create, :name => will.name, :password => 'secret'
    assert_redirected_to admin_url
    assert_equal will.id, session[:user_id]
  end

  test "should fail login" do
    dave = users(:one)
    post :create, :name => will.name, :password => 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to catalog_url
  end

end