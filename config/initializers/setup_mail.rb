ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :from => 'website@gmail.com'
ActionMailer::Base.smtp_settings = {

:address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "sidhant.mehta01",
  :password             => "JaiGanesh19",
  :authentication       => "plain",
  :enable_starttls_auto => true

}
