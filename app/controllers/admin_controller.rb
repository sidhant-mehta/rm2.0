class AdminController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :setVars
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
  end

  def create_project
  end

  def edit_project
  end
 
  def list_projects
  end

  def update_project
  end

  def new_client
  end

  def create_client
  end
  
  def edit_client
  end

  def update_client
  end
  
  def list_clients
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
  end
  def create_employer_profile
  end
  def edit_employer_profile
  end
  def update_employer_profile
  end
  def list_employer_profiles
  end

end
