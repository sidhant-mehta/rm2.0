class MembersController < ApplicationController
before_filter :authenticate_member!
layout 'admin'

#------- LOCAL METHODS -----------
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


#----------------END LOCAL METHODS ------------------------



  def dashboard
    @member = Member.find(current_member.id)
     @all_mentor_apps= getMemberMentorApplications(current_member.id)
     @all_project_apps= getMemberProjectApplications(current_member.id)
     @all_job_apps= getMemberJobApplications(current_member.id)
     @limit = 5 #limit for how many to show
  end
  
  def applications 
   @member = Member.find(current_member.id)
   getMemberMentorApplications(current_member.id)
   getMemberProjectApplications(current_member.id)
   getMemberJobApplications(current_member.id)
  end
  
  def settings
    @member = Member.find(current_member.id)

  end
  
  def profile
    #date saved in american format in db.
    @member = Member.find(current_member.id)
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
     
    @member = Member.find(current_member.id)
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