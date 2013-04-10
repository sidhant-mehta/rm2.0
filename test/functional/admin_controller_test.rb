require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get adverts" do
    get :adverts
    assert_response :success
  end

  test "should get team" do
    get :team
    assert_response :success
  end

  test "should get members" do
    get :members
    assert_response :success
  end

  test "should get mentors" do
    get :mentors
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

  test "should get clients" do
    get :clients
    assert_response :success
  end

  test "should get jobs" do
    get :jobs
    assert_response :success
  end

  test "should get employer_profiles" do
    get :employer_profiles
    assert_response :success
  end

end
