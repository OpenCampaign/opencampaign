begin
  require 'rspec/core/rake task'
  RSpec::Core::RakeTask.new(:spec)

  task rspec: :spec
  task default: :rspec
rescue LoadError
  desc 'rspec rake task not available (rspec not installed)'
  task :rspec do
    abort 'RSpec rake task is not available. Be sure to install rspec via bundle install.'
  end
end
