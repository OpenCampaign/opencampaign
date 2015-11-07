namespace :roles do

  desc 'Create Role::DEFAULTS roles'
  task :create => :environment do
    Role::DEFAULTS.each do |name, title|
      role = Role.new
      role.name = name
      if role.valid?
        role.save
        puts '-'*10
        puts "Role '#{name}' created."
      else
        puts '-'*10
        puts "Role '#{name}' could not be created: "
        role.errors.each do |field, message|
          puts "#{field}: #{message}"
        end
      end
    end
  end

end
