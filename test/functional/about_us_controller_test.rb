require 'test_helper'

class AboutUsControllerTest < ActionController::TestCase
  test "should get what_we_do" do
    get :what_we_do
    assert_response :success
  end

  test "should get how_it_works" do
    get :how_it_works
    assert_response :success
  end

  test "should get our_philosophy" do
    get :our_philosophy
    assert_response :success
  end

  test "should get meet_the_team" do
    get :meet_the_team
    assert_response :success
  end

end
