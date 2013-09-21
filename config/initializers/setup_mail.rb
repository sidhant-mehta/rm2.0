ActionMailer::Base.default_url_options = { :host => 'raisonmentors.com' }
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :from => 'do-not-reply@raisonmentors.com'
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	:address => "localhost",
	:port => 25,
	:domain => "raisonmentors.com",
	:authentication => :login,
	:user_name => "do-not-reply@raisonmentors.com",
	:password => "ThisIsSparta300",
	:enable_starttls_auto => true,
	:openssl_verify_mode  => 'none'
}