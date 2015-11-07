Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_API_KEY']
  config.host =    ENV['ERRBIT_HOST']
  config.secure = true
end
