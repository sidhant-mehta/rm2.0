ActionMailer::Base.smtp_settings = {

:address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "sidhant.mehta01",
  :password             => "***",
  :authentication       => "plain",
  :enable_starttls_auto => true


}