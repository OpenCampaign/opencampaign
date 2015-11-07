if Rails.env.production?
  Rails.application.config.secret_token = ENV['SECRET_TOKEN']
else
  Rails.application.config.secret_token = ('x' * 30) # meets minimum requirement of 30 chars long
end
