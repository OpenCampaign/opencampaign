# Used with BasicAuth model (omniauth-identity)
# But can't share the same module||class name
# NOT related to Identity model except to create an identity instance
module Authentication
  module IdentityAuth
    PROVIDER = 'identity'

    def auth_hash
      env['omniauth.auth']
    end

    def uid
      auth_hash['uid']
    end

    def find_or_create_by_uid(uid=nil)
      user     = find_by_uid
      identity = Identity.where(provider: PROVIDER, uid: uid).try(:first)
      identity = create_identity(user) if identity.blank?
      user     = identity.user if identity && user.blank?
      fail! unless user && identity

      user
    end

    def find_by_uid
      identity = Identity.where(provider: PROVIDER, uid: uid).try(:first)
      unless identity.blank?
        update_identity identity
        user = identity.user
      else
        nil
      end
    end

    def create_identity(user=nil)
      identity = nil
      ActiveRecord::Base.transaction do
        identity   = Identity.where(provider: PROVIDER, uid: uid).try(:first)
        identity ||= Identity.new(provider: PROVIDER, uid: uid)
        update_identity(identity)
        if user
          user.identities << identity unless user.identities.include?(identity)
        else
          user = User.new(identities: [identity])
        end
        user.save!
        identity.update_attribute(:user, user)
      end

      identity
    end

    def update_identity(identity)
      identity.updated_at = Time.now
      identity.email      = auth_hash['info']['email']

      # Only update if the param exists, otherwise login form erases value
      identity.username   = params['username'] unless params['username'].blank?
      #identity.name      = auth_hash['info']['name']

      identity.save
      associate_basic_auth_to_identity identity

      identity
    end

    def associate_basic_auth_to_identity(identity)
      basic_auth = BasicAuth.where(id: uid).try(:first)
      if basic_auth
        if basic_auth.identity_id.blank? || basic_auth.identity_id != identity.id
          basic_auth.update_attribute(:identity_id, identity.id)
        end
      end
    end

  end
end
