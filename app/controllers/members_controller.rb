class MembersController < ApplicationController
before_filter :authenticate_member!
  
  layout 'admin'


  def dashboard
    
  end
  
  def applications 
    #TODO find by member_id. 
   @job_applications = MemberJobApplication.all
   @mentor_applications = MemberMentorApplication.all
   @project_applications = MemberProjectApplications.all
  end
  
  def settings
    
  end
  
  def profile
    @member = Member.find(current_member.id)
    @member_sectors_array = @member.sector_ids.split(",")
    
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end
    
     @member_sectors_name = [] #need to initialize this array first
     @member_sectors_array.each_with_index do |s, i| 
       @member_sectors_name << Sector.find(s).id
    end
  end
  
  def update
    @m = Member.find(current_member.id)
    @m.fname = params[:fname]
    @m.lname = params[:lname]
    @m.email = params[:email]
    @m.dob = params[:dob]
    @m.gender = params[:gender]
    @m.telephone = params[:telephone]
    @m.location = params[:location]
    @m.academic_institution = params[:academic_institution]
    @m.course = params[:course]
    @m.sector_ids = params[:sector_ids]
    @m.employment_status = params[:employment_status]
    @m.cv = params[:cv]
#TODO the save function is not working. fix it. make it show errors upon update. 
    if @m.save 
      redirect_to member_path, :notice => 'Your profile has been updated successfully.\n'
    else
      render "profile", :notice => @m.errors
    end
    
  end
  
  def destroy
  end
end
