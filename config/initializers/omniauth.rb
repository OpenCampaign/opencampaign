OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    eval(IO.read(ENV['OA_DEVELOPER_PROVIDER_PATH']), binding)
  else
    #TODO: Extract this out to dynamically load via ENV list
    eval(IO.read(ENV['OA_IDENTITY_PROVIDER_PATH']), binding) # omniauth-identity via BasicAuth model
  end
end
