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
    debugger 
    @application = MemberMentorApplication.new
    @application = MemberMentorApplication.new(:member_id => @member_id, :mentor_id => @mentor_id, :status => "Applied")
    @application.user = Member.find(@member_id)       
       if @application.save    
          redirect_to mentors_path,  :notice => "Your application has been made successfully."
          #TODO send email to HR => mentor name and id, member name and id
       else
         @error_str = ""
         @application.errors.each do |field, msg|
           @error_str = @error_str + "<p class='alert'>" + msg + "</p>"
         end
          redirect_to mentors_path, :alert => @error_str.html_safe 
       end
  end

def project
  
end

end
