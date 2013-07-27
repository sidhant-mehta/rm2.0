class MembersController < ApplicationController
before_filter :authenticate_member!
before_filter :setVars
layout 'admin'

def setVars
    @member = Member.find(current_member.id)
end


#------- LOCAL METHODS -----------
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

def getMemberMentorApplications (member_id)
  
   @mentor_application_ids = MemberMentorApplication.where("member_id = ?", member_id).order("created_at DESC")
   @mentors =[]
   @mentor_application_statuses = []
   @mentor_application_created_at = []
   @mentor_application_id = [] 
   
   @mentor_application_ids.each do |mentor_ap|
     @mentors << Mentor.find(mentor_ap.mentor_id)
     @mentor_application_statuses << mentor_ap.status
     @mentor_application_created_at << mentor_ap.created_at.strftime("%d %b %Y - %H:%M")
     @mentor_application_id << mentor_ap.id
   end
  
end

def getMemberProjectApplications (member_id)
  
   @project_application_ids = MemberProjectApplication.where("member_id = ?", member_id).order("created_at DESC")
   @projects =[]
   @project_application_statuses = []
   @project_application_created_at = []
   @project_application_id =[]
   
   @project_application_ids.each do |project_ap|
     @projects << Project.find(project_ap.project_id)
     @project_application_statuses << project_ap.status
     @project_application_created_at << project_ap.created_at.strftime("%d %b %Y - %H:%M")
     @project_application_id << project_ap.id
   end
  
end

def getMemberJobApplications (member_id)
  
   @job_application_ids = MemberJobApplication.where("member_id = ?", member_id).order("created_at DESC")
   @jobs =[]
   @job_application_statuses = []
   @job_application_created_at = []
   @job_application_id =[]
   
   @job_application_ids.each do |job_ap|
     @jobs << Job.find(job_ap.job_id)
     @job_application_statuses << job_ap.status
     @job_application_created_at << job_ap.created_at.strftime("%d %b %Y - %H:%M")
     @job_application_id << job_ap.id
   end
  
end

def getMentorId (email) #this will get the Mentor ID for the Member who has signed up to become a mentor.
  m = Mentor.find_by_email email
  if m.nil?
    return -1
  else
    return m.id
  end
end

#----------------END LOCAL METHODS ------------------------


#----- MENTORSHIP -----

def new_mentor
  @mentor = Mentor.new
  @mentor.email = current_member.email
  @sectors=[]
  Sector.all.each_with_index do |s,i|
    @sectors << Sector.find(s)
  end
  respond_to do |format|
    format.html # new.html.erb
    format.json { render json: @mentor }
  end
  
end

def create_mentor
  m = clean_select_multiple_params params[:mentor]
  m["sector_ids"] = m["sector_ids"].join(',')
  @mentor = Mentor.new(m)
   @sectors=[]
  Sector.all.each_with_index do |s,i|
    @sectors << Sector.find(s)
  end
   if @mentor.sector_ids.blank?
   else   
      @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
      @mentor_sectors_ids = [] #need to initialize this array first
       @mentor_sectors_ids_array.each_with_index do |s, i| 
         @mentor_sectors_ids << Sector.find(s).id
      end
    end
    
    respond_to do |format|
          if @mentor.email== current_member.email
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
        else
          flash.now[:alert] = ("<p>Please make sure that the email address you have entered is the same as the one you are currently registered with. </p>").html_safe
              
          format.html { render action: "new_mentor" }
        end
    end
end

def update_mentor
      m = clean_select_multiple_params params[:mentor]
      m["sector_ids"] = m["sector_ids"].join(',')

      @mentor = Mentor.find(m["id"])
       @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
     if @mentor.sector_ids.blank?
     else   
        @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
        @mentor_sectors_ids = [] #need to initialize this array first
         @mentor_sectors_ids_array.each_with_index do |s, i| 
           @mentor_sectors_ids << Sector.find(s).id
     end
    end
       
       
    respond_to do |format|
      if params[:mentor][:email] == current_member.email
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
      else
          flash.now[:alert] = ("<p>Please make sure that the email address you have entered is the same as the one you are currently registered with. </p>").html_safe
              
          format.html { render action: "new_mentor" }
        end
    end
end

def edit_mentor
    
    mentor_id = getMentorId(current_member.email)
    if mentor_id == -1 #if there is an error in finding the mentor id then likely it does not exist, so create one. 
      redirect_to "new_mentor"
    else
      @mentor = Mentor.find(mentor_id)
         
      @sectors=[]
      Sector.all.each_with_index do |s,i|
        @sectors << Sector.find(s)
      end
       if @mentor.sector_ids.blank?
       else   
          @mentor_sectors_ids_array = @mentor.sector_ids.split(",")
          @mentor_sectors_ids = [] #need to initialize this array first
           @mentor_sectors_ids_array.each_with_index do |s, i| 
             @mentor_sectors_ids << Sector.find(s).id
       end
      end  
    end
end

def list_internal_mentors
  org = OrganisationEmailDomain.getOrganisation current_member.email
  @mentors = Mentor.where(:organisation => org, :internal => true)  
  @type_address ="members/mentor"
  @type = "mentor"
  @sectors=[]
      Sector.all.each_with_index do |s,i|
        @sectors << Sector.find(s)
      end
end

def destroy_mentor
  mentor_id = getMentorId(current_member.email)
  @mentor = Mentor.find(mentor_id)
end

def search_mentor
   @type = "mentor"
   @type_address = "members/mentor"
   org = OrganisationEmailDomain.getOrganisation current_member.email
     if ( params.has_key?(:mentor_name) )
           @search_name =params[:mentor_name].split(" ")    
     else
            @search_name =""
     end
     
    @search_sector = params[:sector_id]
    @search_closing_date = params[:closing_date]
    
    @sectors = Sector.find(:all, :order=>'name')
    @result_mentors = Mentor.search(@search_name[0], @search_name[1], @search_sector, @search_closing_date )
    @mentors = @result_mentors.where(:organisation => org, :internal => true)  
    
    render "list_internal_mentors"
end
  
#----END MENTORSHIP----
#--------PROJECTS -----

def add_project
  
end

def list_internal_projects
  org = OrganisationEmailDomain.getOrganisation current_member.email
  @projects = Project.where(:organisation => org, :internal => true)  
  @type_address ="members/project"
  @type = "project"
  @sectors=[]
      Sector.all.each_with_index do |s,i|
        @sectors << Sector.find(s)
      end
end

def search_project
   org = OrganisationEmailDomain.getOrganisation current_member.email
   @type_address = "members/project"
   @type = "project"
     if ( params.has_key?(:project_name) )
           @search_name =params[:project_name]    
     else
            @search_name =""
     end
     
    @search_sector = params[:sector_id]
    @search_closing_date = params[:closing_date]
    @search_pay_value = params[:pay_value]
    
    @sectors = Sector.find(:all, :order=>'name')
    @result_projects = Project.search(@search_name[0], @search_sector, @search_closing_date, @search_pay_value )
    @projects = @result_projects.where(:organisation => org, :internal => true)  
    
    render "list_internal_projects"
end

#------END PROJECTS-----

#-------PROFILE ----------
  def dashboard
     @all_mentor_apps= getMemberMentorApplications(current_member.id)
     @all_project_apps= getMemberProjectApplications(current_member.id)
     @all_job_apps= getMemberJobApplications(current_member.id)
     @limit = 5 #limit for how many to show
  end
  
  def applications 
  
   getMemberMentorApplications(current_member.id)
   getMemberProjectApplications(current_member.id)
   getMemberJobApplications(current_member.id)
  end
  
  def settings
   

  end
  
  def profile
    #date saved in american format in db.
   
    @locations = Location.all
    
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
     if @member.sector_ids.blank?
     else   
         @member_sectors_ids_array = @member.sector_ids.split(",")
         @member_sectors_ids = [] #need to initialize this array first
         @member_sectors_ids_array.each_with_index do |s, i| 
           @member_sectors_ids << Sector.find(s).id
     end
    end
  end
  
  def update
    @locations = Location.all
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
     
   
    @member.fname = params[:fname]
    @member.lname = params[:lname]
    @member.email = params[:email]
    @member.dob = params[:dob]
    @member.gender = params[:gender]
    @member.telephone = params[:telephone]
    @member.location = params[:location]
    @member.academic_institution = params[:academic_institution]
    @member.course = params[:course]
    @member.sector_ids = params[:sector_ids].join(',')
    @member.employment_status = params[:employment_status]
    @member.cv = params[:cv]
    
    @member_sectors_ids_array = @member.sector_ids.split(",")
    @member_sectors_ids = [] #need to initialize this array first
    @member_sectors_ids_array.each_with_index do |s, i| 
       @member_sectors_ids << Sector.find(s).id
     end    
    

    if @member.save 
      flash[:notice] = "Your profile has been updated successfully."
    
      respond_to do |format|
        format.html { redirect_to members_dashboard_path }
      end
    else
      @error_str = ""
      @member.errors.each do |field, msg|
            @error_str = @error_str + msg + " "
      end
      
      flash.now[:alert] = @error_str
      
      respond_to do |format|
        format.html { render member_path }
      end
    
    end
    
  end
  
  def destroy
  end
end

class Member::RegistrationsController < Devise::RegistrationsController
  def new
        resource = build_resource({})
        respond_with resource
  end
end
#-----END PROFILE-----
