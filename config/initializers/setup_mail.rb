ActionMailer::Base.smtp_settings = {
  :address              => "mail.raisonmentors.com",
  :user_name            => "website",
  :password             => "ThisIsSparta300",
  :authentication       => "plain",
  :enable_starttls_auto => true
}