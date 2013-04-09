require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { closing_date: @project.closing_date, description: @project.description, draft: @project.draft, email: @project.email, location: @project.location, name: @project.name, organisation: @project.organisation, project_leader: @project.project_leader, sector_ids: @project.sector_ids, telephone: @project.telephone }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    put :update, id: @project, project: { closing_date: @project.closing_date, description: @project.description, draft: @project.draft, email: @project.email, location: @project.location, name: @project.name, organisation: @project.organisation, project_leader: @project.project_leader, sector_ids: @project.sector_ids, telephone: @project.telephone }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
