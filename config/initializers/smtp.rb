# mailtrap.io config
Rails.application.config.action_mailer.delivery_method = :smtp
Rails.application.config.action_mailer.default_url_options = {
  host: ENV['SITE_DOMAIN']
}
Rails.application.config.action_mailer.smtp_settings = {
  :user_name => ENV['SMTP_USER'],
  :password => ENV['SMTP_PASSWORD'],
  :address => ENV['SMTP_ADDRESS'],
  :domain => ENV['SMTP_DOMAIN'],
  :port => ENV['SMTP_PORT'],
  :authentication => ENV['SMTP_AUTHENTICATION'].to_sym,
  :enable_starttls_auto => ENV['SMTP_STARTTLS']
}
