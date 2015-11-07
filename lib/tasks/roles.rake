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

  desc 'Grant admin role to user_id'
  task :grant_admin, [:email, :provider] => :environment do |t, args|
    args.with_defaults(:provider => 'identity')
    user = args.provider.classify.constantize.where(email: args.email).first.user
    user.add_role('admin')
    puts "User #{user.name} is now an admin!"
  end
end
