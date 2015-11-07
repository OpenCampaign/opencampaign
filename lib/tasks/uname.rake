desc 'return results of `uname -a`'
task :uname do
  stdout = `uname -a`
  puts "uname -a: #{stdout}"
end
