desc 'Generate HTML reports & coverage'
task :reports do
  ENV['COVERAGE'] = 'true'
  system "cd #{Rails.root}"
  system "bundle exec cucumber -f html -o cucumber.html"
  system "bundle exec rspec -f html -o rspec.html"
  system "bundle exec brakeman -f html -o security.html"
end
