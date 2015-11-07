class User < ActiveRecord::Base
  rolify
  pattr_initialize :current_identity

  has_many :identities, dependent: :destroy
  after_save :associate_identities

  validates_presence_of :identities

  def current_identity
    @current_identity || identities.order("updated_at").last
  end

  def basic_auth
    ba = BasicAuth.where(email: email).try(:first)
    ba.blank? ? nil : ba
  end

  def username
    @username ||= current_identity.username
  end

  def name
    name_priorities = %w( name username email )
    if @name.blank?
      name_priorities.each do |name_field|
        @name = current_identity.send(name_field.to_sym) if @name.blank?
      end
    end

    @name
  end

  def email
    @email ||= current_identity.email
  end

  def phone
    @phone ||= current_identity.phone
  end

  def phone_secondary
    @phone ||= current_identity.phone_secondary
  end

  def affiliation
    @affiliation ||= current_identity.affiliation
  end

  private

  def associate_identities
    identities.each do |identity|
      identity.update_attribute(:user_id, id)
    end
  end
end
