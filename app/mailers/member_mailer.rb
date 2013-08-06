class MemberMailer < ActionMailer::Base

    def mentor_application_confirmation (app)
        @member = app.user
        @mentor = Mentor.find(app.mentor_id)
        mail(:to => @member.email, :subject => "Your application has been made successfully.")
        
    end
    
    def project_application_confirmation (app)
        @member = app.user
        @project = Project.find(app.project_id)
        mail(:to => @member.email, :subject => "Your application has been made successfully.")
        
    end

end