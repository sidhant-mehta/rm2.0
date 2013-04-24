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
    #TODO change the date format to DD-MM-YYYY here or change it in the model.
    @member = Member.find(current_member.id)
    @locations = Location.all
    
    @sectors=[]
    Sector.all.each_with_index do |s,i|
      @sectors << Sector.find(s)
    end

     @member_sectors_ids_array = @member.sector_ids.split(",")
     @member_sectors_ids = [] #need to initialize this array first
     @member_sectors_ids_array.each_with_index do |s, i| 
       @member_sectors_ids << Sector.find(s).id
    end
  end
  
  def update
    #TODO change the date format to DD-MM-YYYY here or change it in the model.
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
    

#TODO the save function is not working. fix it. make it show errors upon update. 
    if @member.save 
      redirect_to member_path, :notice => "Your profile has been updated successfully."
    else
      render "profile", :notice => @member.sector_ids
    end
    
  end
  
  def destroy
  end
end
