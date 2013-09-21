class HrMailer < ActionMailer::Base
  
   def mentor_application_confirmation (app)
        @member = app.user
        @mentor = Mentor.find(app.mentor_id)
        attachments["#{@member.cv}"] = File.read(@member.cv.path)
        mail(:to => "hr@raisonmentors.com", :subject => "#{@member.fname} #{@member.lname} has made an application for the mentor, #{@mentor.fname} #{@mentor.lname}")
    end
    
    def project_application_confirmation (app)
        @member = app.user
        @project = Project.find(app.project_id)
        attachments["#{@member.cv}"] = File.read(@member.cv.path)
        mail(:to => "hr@raisonmentors.com", :subject => "#{@member.fname} #{@member.lname} has made an application for the project, #{@project.name}")
    end    
end