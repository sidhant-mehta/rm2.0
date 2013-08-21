class ClientsController < ApplicationController
    before_filter :authenticate_client!
    before_filter :setVars
    layout 'admin'
 #---------LOCAL METHODS ------------------
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
  @mentor_application_data = Mentor.select("member_mentor_applications.mentor_id, mentors.fname, mentors.lname, member_mentor_applications.id, member_mentor_applications.created_at, member_mentor_applications.status").joins("JOIN member_mentor_applications ON mentors.id = member_mentor_applications.mentor_id").where('mentors.organisation = ?', client_org)
  return @mentor_application_data
end

def getProjectApplications(client_org)
  @project_applicatoin_data = Project.select("member_project_applications.project_id, projects.name, member_project_applications.id, member_project_applications.created_at, member_project_applications.status").joins("JOIN member_project_applications ON projects.id = member_project_applications.project_id").where('projects.organisation = ?', client_org)
end
  
  
#---- END LOCAL METHDOS ---------------------  
  
  def list_projects
      if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
        org = OrganisationEmailDomain.getOrganisation current_client.email
        @projects = Project.where(:organisation => org)
        @sectors = Sector.find(:all, :order=>'name')
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @project }
        end

    else
        respond_to do |format|
              format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
          end
    end
  end

  def new_project
    @action_address = "create_project"
    if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
        @project = Project.new
        @project.organisation = OrganisationEmailDomain.getOrganisation current_client.email
        #@project_sectors_ids = {}
        #@project.email = current_client.email
        @sectors = []
        Sector.all.each_with_index do |s,i|
            @sectors << Sector.find(s)
          end
        
        respond_to do |format|
          format.html
          format.json {render json: @project}
        end
    else
        respond_to do |format|
          format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
        end
    end
  end
  
  def create_project
    @action_address = "create_project"
    p = clean_select_multiple_params params[:project]
    p["sector_ids"] = p["sector_ids"].join(',')
    @project = Project.new(p)
    @project.skip_email_check = true
    @project.user = current_client
    
    @sectors = []
        Sector.all.each_with_index do |s,i|
            @sectors << Sector.find(s)
          end
          
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

  def update_project
    @action_address = "update_project"
    p = clean_select_multiple_params params[:project]
    p["sector_ids"] = p["sector_ids"].join(',')
    
    @project = Project.find(p["id"])
    @project.skip_email_check = true
    @project.user = current_client
    
    @sectors = []
    Sector.all.each_with_index do |s,i|
        @sectors << Sector.find(s)
      end
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

  def list_mentors
    if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
        @mentors = Mentor.where(:organisation => EmployerProfile.find(current_client.id).name)
        @sectors = Sector.find(:all, :order=>'name')
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @mentors }
        end

    else
        respond_to do |format|
              format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
          end
    end

  end

  def new_mentor
    @action_address = "create_mentor"
    if (EmployerProfile.exists?(current_client.id) && !EmployerProfile.find(current_client.id).name.blank?)
          @mentor = Mentor.new
          @mentor.organisation = EmployerProfile.find(current_client.id).name
          @sectors=[]
          Sector.all.each_with_index do |s,i|
            @sectors << Sector.find(s)
          end
          
          respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @mentor }
          end
    else
          respond_to do |format|
              format.html {redirect_to clients_profile_path, alert:"You must complete your profile before adding, editing or viewing any Mentors or Projects."}
          end
    end

  end

  # POST /create_mentor
  # POST /create_mentor.json
  def create_mentor
    @action_address = "create_mentor"
    m = clean_select_multiple_params params[:mentor]
    m["sector_ids"] = m["sector_ids"].join(',')
    @mentor = Mentor.new(m)
    @mentor.skip_email_check = true
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
  
  # GET /mentors/1/edit
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
  
  def list_jobs
  end

  def add_job
  end

  def edit_job
  end

  def dashboard
    org = OrganisationEmailDomain.getOrganisation(current_client.email)
    @mentor_application_data = getMentorApplications(org)
    @project_application_data = getProjectApplications(org)
    @limit = 10
    
  end

  def profile # employer profile
    #get the employer profile record that is already in place. Or create a new one which has the same organisation name as the current client, as this one client is responsible for the company.
    
    org =OrganisationEmailDomain.getOrganisation (current_client.email)
    if ( !EmployerProfile.exists?(:name => org) )
        @employer_profile = EmployerProfile.new
        @employer_profile.name = org
        @employer_profile.bio = " "
       # @employer_profile.id = current_client.id
        @employer_profile.user = current_client
        @employer_profile.save
    end
    
    
    @employer_profile = EmployerProfile.find_by_name org
    if @employer_profile.sector_ids.blank?
    else   
        @employer_profile_sectors_ids_array = @employer_profile.sector_ids.split(",")
        @employer_profile_sectors_ids = [] #need to initialize this array first
         @employer_profile_sectors_ids_array.each_with_index do |s, i| 
           @employer_profile_sectors_ids << Sector.find(s).id
          end
    end
  end

  def profile_update
       org =OrganisationEmailDomain.getOrganisation (current_client.email)
        
       ep = clean_select_multiple_params params[:employer_profile]
       ep["sector_ids"] = ep["sector_ids"].join(',')
 
       @employer_profile = EmployerProfile.find_by_name org
       @employer_profile.user = current_client
 
       respond_to do |format|
         if @employer_profile.update_attributes(params[:employer_profile]) 
           format.html { redirect_to clients_profile_path, notice: "Profile was successfully updated."}
           format.json{head :no_content}
         else
            @error_str = ""
            @employer_profile.errors.each do |field, msg|
              @error_str = @error_str + "<p>" + msg + "</p>"
            end
            flash[:alert] = @error_str.html_safe
            
            format.html { render action: "profile"}
         end
       end
  end 
  
  def settings
    @client = current_client
  end
  
  def update_client
  end
end
