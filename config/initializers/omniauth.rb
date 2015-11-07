OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  eval(IO.read(ENV['OA_PROVIDER_PATH']), binding)
end
