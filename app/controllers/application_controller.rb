class ApplicationController < ActionController::Base
  before_filter :require_login, only: [:mentor]
  #protect_from_forgery
 # private
 
  def require_login
    if current_member.nil? || current_member.id == -1
      flash[:alert] = "You must be logged in before making an application."
      redirect_to new_member_session_path # halts request cycle
    end
  end


  def mentor
  
    params[:member_id].each do |key,value|
        @member_id = value.to_i
    end 
    params[:mentor_id].each do |key,value|
        @mentor_id = value.to_i
    end
    @application = MemberMentorApplication.new
    @application = MemberMentorApplication.new(:member_id => @member_id, :mentor_id => @mentor_id, :status => "Applied")
    @application.user = Member.find(@member_id)       
       
       if @application.save    
          MemberMailer.mentor_application_confirmation(@application ).deliver #send email to member
          HrMailer.mentor_application_confirmation(@application).deliver #send email to HR
                    
          redirect_to mentors_path,  :notice => "Your application has been made successfully."
       else
         @error_str = ""
         @application.errors.each do |field, msg|
           @error_str = @error_str + "<p class='alert'>" + msg + "</p>"
         end
          redirect_to mentors_path, :alert => @error_str.html_safe 
       end
  end

  def project
    params[:member_id].each do |key,value|
        @member_id = value.to_i
    end 
    params[:project_id].each do |key,value|
        @project_id = value.to_i
    end
    @application = MemberProjectApplication.new
    @application = MemberProjectApplication.new(:member_id => @member_id, :project_id => @project_id, :status => "Applied")
    @application.user = Member.find(@member_id)       
       
       if @application.save    
          MemberMailer.project_application_confirmation(@application ).deliver #send email to member
          HrMailer.project_application_confirmation(@application).deliver #send email to HR
                    
          redirect_to projects_path,  :notice => "Your application has been made successfully."
       else
         @error_str = ""
         @application.errors.each do |field, msg|
           @error_str = @error_str + "<p class='alert'>" + msg + "</p>"
         end
          redirect_to projects_path, :alert => @error_str.html_safe 
       end
    
  end

end
