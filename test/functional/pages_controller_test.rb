require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get our_policy" do
    get :our_policy
    assert_response :success
  end

  test "should get terms_of_use" do
    get :terms_of_use
    assert_response :success
  end

  test "should get terms_and_conditions" do
    get :terms_and_conditions
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get confirmation" do
    get :confirmation
    assert_response :success
  end

  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
