require 'test_helper'

class EmployerProfilesControllerTest < ActionController::TestCase
  setup do
    @employer_profile = employer_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employer_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employer_profile" do
    assert_difference('EmployerProfile.count') do
      post :create, employer_profile: { bio: @employer_profile.bio, name: @employer_profile.name }
    end

    assert_redirected_to employer_profile_path(assigns(:employer_profile))
  end

  test "should show employer_profile" do
    get :show, id: @employer_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employer_profile
    assert_response :success
  end

  test "should update employer_profile" do
    put :update, id: @employer_profile, employer_profile: { bio: @employer_profile.bio, name: @employer_profile.name }
    assert_redirected_to employer_profile_path(assigns(:employer_profile))
  end

  test "should destroy employer_profile" do
    assert_difference('EmployerProfile.count', -1) do
      delete :destroy, id: @employer_profile
    end

    assert_redirected_to employer_profiles_path
  end
end
