class AdminController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :setVars
  around_filter :catch_not_found
  layout 'admin'

#---------------LOCAL METHODS -------------------
  def clean_select_multiple_params hash = params
  hash.each do |k, v|
    case v
    when Array
       v.reject!(&:blank?)
       v.join(',')
    when Hash then clean_select_multiple_params(v)
    end
  end
end  

def setVars
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
end

def getMentorApplications(client_org)
  @mentor_application_data = Mentor.select("member_mentor_applications.mentor_id, mentors.fname, mentors.lname, member_mentor_applications.id, member_mentor_applications.created_at, member_mentor_applications.status").joins("JOIN member_mentor_applications ON mentors.id = member_mentor_applications.mentor_id") 
  return @mentor_application_data
end

def getProjectApplications(client_org)
  @project_applicatoin_data = Project.select("member_project_applications.project_id, projects.name, member_project_applications.id, member_project_applications.created_at, member_project_applications.status").joins("JOIN member_project_applications ON projects.id = member_project_applications.project_id")
end

#---------------------------------------------------

  def login
  end

  def dashboard
    org = true
    @mentor_application_data = getMentorApplications(org)
    @project_application_data = getProjectApplications(org)
    @limit = 10
    
  end

  def adverts
  end

  def team
  end

  def members
  end

  def new_mentor
    @action_address = "create_mentor"
    @mentor = Mentor.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor }
    end
  end
  
  def create_mentor
    @action_address = "create_mentor"
    m = clean_select_multiple_params params[:mentor]
    m["sector_ids"] = m["sector_ids"].join(',')
    @mentor = Mentor.new(m)
    @mentor.skip_email_check = true
    @mentor.skip_organisation_check = true
    @mentor.user = current_client
    if @mentor.sector_ids.blank?
    else   
        @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
        @mentor_sectors_ids = [] #need to initialize this array first
         @mentor_sectors_ids_array.each_with_index do |s, i| 
           @mentor_sectors_ids << Sector.find(s).id
          end
    end
    respond_to do |format|
      if @mentor.save
        format.html { redirect_to @mentor, notice: 'Mentor was successfully created.' }
        format.json { render json: @mentor, status: :created, location: @mentor }
      else
        @error_str = ""
        @mentor.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
        end
        
        flash.now[:alert] = @error_str.html_safe
        
        format.html { render action: "new_mentor" }
        #format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list_mentors
        @mentors = Mentor.all
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @mentors }
        end

  end
  
  def edit_mentor
    @action_address = "update_mentor"
    @mentor = Mentor.find(params[:id])
    
     if @mentor.sector_ids.blank?
     else   
        @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
        @mentor_sectors_ids = [] #need to initialize this array first
         @mentor_sectors_ids_array.each_with_index do |s, i| 
           @mentor_sectors_ids << Sector.find(s).id
     end
    end    
  end

  def update_mentor
    @action_address = "update_mentor"
      m = clean_select_multiple_params params[:mentor]
      m["sector_ids"] = m["sector_ids"].join(',')

      @mentor = Mentor.find(m["id"])
      @mentor.skip_email_check = true
      @mentor.skip_organisation_check=true
      @mentor.user = current_client

    if @mentor.sector_ids.blank?
    else   
        @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
        @mentor_sectors_ids = [] #need to initialize this array first
         @mentor_sectors_ids_array.each_with_index do |s, i| 
           @mentor_sectors_ids << Sector.find(s).id
         end
    end

    respond_to do |format|
      if @mentor.update_attributes(params[:mentor])
        format.html { redirect_to @mentor, notice: 'Mentor was successfully updated.' }
        format.json { head :no_content }
      else
        @error_str = ""
        @mentor.errors.each do |field, msg|
          @error_str = @error_str + "<p>" + msg + "</p>"
        end
        flash[:alert] = @error_str.html_safe
        
        format.html { render action: "edit_mentor"}
      end
    end
  end
  
  def new_project
    @action_address = "create_project"
        @project = Project.new
        
        respond_to do |format|
          format.html
          format.json {render json: @project}
        end
  end

  def create_project
    @action_address = "create_project"
    p = clean_select_multiple_params params[:project]
    p["sector_ids"] = p["sector_ids"].join(',')
    @project = Project.new(p)
    @project.skip_email_check = true
    @project.skip_organisation_check = true
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        @error_str = ""
        @project.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
        end
        
        flash.now[:alert] = @error_str.html_safe
        
        format.html { render action: "new_project" }
      end
    end
  end

  def edit_project
    @action_address = "update_project"
    @project = Project.find(params[:id])
    
     if @project.sector_ids.blank?
     else   
        @project_sectors_ids_array = @project.sector_ids.split(",")
        @project_sectors_ids = [] #need to initialize this array first
         @project_sectors_ids_array.each_with_index do |s, i| 
           @project_sectors_ids << Sector.find(s).id
         end
     end
     
  end
 
  def list_projects
        @projects = Project.all
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @project }
        end
  end

  def update_project
    @action_address = "update_project"
    p = clean_select_multiple_params params[:project]
    p["sector_ids"] = p["sector_ids"].join(',')
    
    @project = Project.find(p["id"])
    @project.skip_email_check = true
    @project.skip_organisation_check=true
        
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        @error_str = ""
        @project.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
        end
        flash.now[:alert] = @error_str.html_safe
        format.html { render action: "edit_project" }
      end
    end
  end

 
  def edit_client
  end

  def update_client
  end
  
  def list_clients
    @clients = Client.all
    
  end  
  
  def destroy_client
    @client = Client.find(params[:id])
    if @client.destroy
         respond_to do |format|
          format.html { redirect_to admin_list_clients_path, :notice => "Client has been deleted successfully." }      
        end
    else
       @error_str = ""
        @project.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
        end
        flash.now[:alert] = @error_str.html_safe
        format.html { render action: "edit_project" }
    end    
    
  end

  def new_jobs
  end
  
  def create_jobs
  end
  
  def edit_jobs
  end
  
  def update_jobs
  end
  
  def list_jobs
  end

  def new_employer_profile
    @employer_profile = EmployerProfile.new
    @action_address = "create_employer_profile"
  end
  def create_employer_profile
    ep = params[:employer_profile]
    @employer_profile = EmployerProfile.new(ep)
    @employer_profile.skipEmailVsOrganisationCheck= true
    @action_address= "create_employer_profile"
    respond_to do |format|
      if @employer_profile.save
        format.html { redirect_to @employer_profile, notice: "Employer Profile was successfully created."}
        format.json {render json: @employer_profile, status: :created, location: @employer_profile}
      else
        @error_str = ""
        @employer_profile.errors.each do |field, msg|
          @error_str = @error_str + "<p>" + msg + "</p>"
        end
        flash.now[:alert] = @error_str.html_safe
        format.html {render action: "new_employer_profile"}
      end
    end
  end

  def edit_employer_profile
      @employer_profile = EmployerProfile.find(params[:id])
      @action_address= "update_employer_profile"
  end
  def update_employer_profile
      @action_address= "update_employer_profile"
      @employer_profile = EmployerProfile.find(params[:id])
      @employer_profile.skipEmailVsOrganisationCheck = true
     
     respond_to do |format|
      if @employer_profile.update_attributes(params[:employer_profile])
        format.html {redirect_to @employer_profile, notice: "Employer Profile was updated successfully."}
        format.json {head :no_content}
      else
        @error_str = ""
            @employer_profile.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
            end
            flash[:alert] = @error_str.html_safe
            
            format.html { render action: "edit_employer_profile"}
      end
    end
  end
  def list_employer_profiles
    @employer_profiles = EmployerProfile.all
  end
  
  def edit_member
    @member = Member.find(params[:id])
    @action_address = "update_member"
    
    @locations = Location.all
     if @member.sector_ids.blank?
     else   
         @member_sectors_ids_array = @member.sector_ids.split(",")
         @member_sectors_ids = [] #need to initialize this array first
         @member_sectors_ids_array.each_with_index do |s, i| 
           @member_sectors_ids << Sector.find(s).id
     end
    end
  end

  def update_member
    @action_address = "update_member"
    m = clean_select_multiple_params params[:member]
    m["sector_ids"] = m["sector_ids"].join(',')
    @member = Member.find(params[:id])
    @locations = Location.all
    
     if @member .sector_ids.blank?
     else   
        @member_sectors_ids_array = @member.sector_ids.split(",")
        @member_sectors_ids = [] #need to initialize this array first
         @member_sectors_ids_array.each_with_index do |s, i| 
           @member_sectors_ids << Sector.find(s).id
     end
    end
      
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to admin_edit_member_path + '/' + @member.id.to_s, notice: 'Your profile has been updated successfully.' }
        #format.json { head :no_content }
      else
        @error_str = ""
        @member.errors.each do |field, msg|
          @error_str = @error_str + "<p>" + msg + "</p>"
        end
        flash[:alert] = @error_str.html_safe
        format.html { render action: "edit_member/#{@member.id}"}
      end
    end
  end
  
  def list_members
    @members = Member.all
  end  


#-------PRIVATE-----
private

def catch_not_found
  yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :alert => "Record not found." }
end

end
