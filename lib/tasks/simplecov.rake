desc 'Run simplcov code coverage tool'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['default'].invoke
end
