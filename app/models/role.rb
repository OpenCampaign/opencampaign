class Role < ActiveRecord::Base
  require 'toml'
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true
  scopify

  validates :name, presence: true, uniqueness: true
  before_destroy :ensure_not_default_role

  DEFAULTS = TOML.load_file(ENV['ROLES_CONFIG_PATH'], symbolize_keys: true)[:roles]

  def title
    DEFAULTS[name.to_sym].blank? ? name.capitalize : DEFAULTS[name.to_sym][:title]
  end

  def automated?
    !!(DEFAULTS[name.to_sym].blank? ? false : DEFAULTS[name.to_sym][:automated])
  end

  def self.manual
    all.select{ |role| role unless role.automated? }
  end

  def self.update_user_roles(user_params)
    user_ids = User.all.map &:id
    user_ids_with_roles = user_params.keys.map{ |key| key.to_i }
    user_ids_without_roles = user_ids - user_ids_with_roles

    # Delete all roles if a user is not present
    user_ids_without_roles.each do |user_id|
      user = User.find(user_id.to_i)
      self.remove_all_roles(user)
    end

    # Update roles on submitted users
    user_ids_with_roles.each do |user_id|
      user = User.find(user_id.to_i)
      roles_ids = user_params[user.id.to_s]["roles"].keys.map{ |key| key.to_i }
      self.assign_roles(user, roles_ids)
    end
    true
  end

  def self.remove_all_roles(object)
    roles = Role.all.select{ |r| r.automated? == false }
    roles.each do |role|
      object.remove_role role.name
    end
    object.roles
  end

  def self.assign_roles(object, roles_or_ids)
    roles_or_ids = Array.wrap(roles_or_ids)
    roles = roles_or_ids.map{ |role_or_id| role_or_id.class == Role ? role_or_id : Role.find(role_or_id.to_i) }

    # Remove non-specified roles
    remove_roles = Role.manual - roles
    remove_roles.each do |role|
      next unless object.roles.include? role
      object.remove_role role.name
    end

    # Add roles that are not currently associated
    roles.each do |role|
      next if object.roles.include? role
      object.add_role role.name
    end
  end

  private

  def ensure_not_default_role
    if Role::DEFAULTS.keys.map{ |k| k.to_s }.include? name
      errors[:base] = "default roles cannot be deleted"
      false
    end
  end

end
