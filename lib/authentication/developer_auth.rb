module Authentication
  module DeveloperAuth
    PROVIDER = 'developer'

    def find_or_create_by_uid uid
      user = find_by_uid uid
      unless user
        ActiveRecord::Base.transaction do
          identity = Identity.new(provider: auth_hash['provider'], uid: auth_hash['uid'])
          update_identity identity
          user = User.new(identities: [identity])
          user.save!
          identity.update_attribute(:user, user)
        end
      end
      raise "You could not be authenticated." unless user

      user
    end

    def find_by_uid uid
      identity = Identity.where(provider: auth_hash['provider'], uid: auth_hash['uid']).first
      unless identity.blank?
        update_identity identity
        user = identity.user
      else
        nil
      end
    end

    def uid value=nil
      value || "johnlocke"
    end

    def auth_hash
      env['omniauth.auth']
    end

    def update_identity identity
      identity.username = auth_hash['info']['username']
      identity.email    = auth_hash['info']['email']
      identity.name     = auth_hash['info']['name']
      identity.save
    end

  end
end
