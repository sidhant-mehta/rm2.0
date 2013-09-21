class PagesMailer < ActionMailer::Base

  def contact_us_initial_reply (user)
    @user = user
    mail(:to => @user["email"], :subject => "Thank you for contacting Raison Mentors")
  end

  def contact_us_forward_to_info (user)
    @user = user
    mail(:to => "info@raisonmentors.com", :subject => "#{@user['name']} has contacted the website.")
  end

end
