require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  test "should get list_projects" do
    get :list_projects
    assert_response :success
  end

  test "should get add_project" do
    get :add_project
    assert_response :success
  end

  test "should get edit_project" do
    get :edit_project
    assert_response :success
  end

  test "should get list_mentors" do
    get :list_mentors
    assert_response :success
  end

  test "should get add_mentor" do
    get :add_mentor
    assert_response :success
  end

  test "should get edit_mentor" do
    get :edit_mentor
    assert_response :success
  end

  test "should get list_jobs" do
    get :list_jobs
    assert_response :success
  end

  test "should get add_job" do
    get :add_job
    assert_response :success
  end

  test "should get edit_job" do
    get :edit_job
    assert_response :success
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get profle" do
    get :profle
    assert_response :success
  end

end
