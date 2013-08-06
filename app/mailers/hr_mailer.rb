class HrMailer < ActionMailer::Base
  
   def mentor_application_confirmation (app)
        @member = app.user
        @mentor = Mentor.find(app.mentor_id)
        #TODO change HR email address to correct one. 
        mail(:to => "sidhant_mehta@yahoo.com", :subject => "#{@member.fname} #{@member.lname} has made an application for the mentor, #{@mentor.fname} #{@mentor.lname}")
    end
    
    def project_application_confirmation (app)
        @member = app.user
        @project = Project.find(app.project_id)
        #TODO change HR email address to correct one. 
        mail(:to => "sidhant_mehta@yahoo.com", :subject => "#{@member.fname} #{@member.lname} has made an application for the project, #{@project.name}")
    end    
end
