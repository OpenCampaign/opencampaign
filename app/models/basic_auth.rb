require 'securerandom'
class BasicAuth < OmniAuth::Identity::Models::ActiveRecord
  belongs_to :identity
  after_create :send_email_validation

  def token_params
    { basic_auth_id: id, token: find_or_create_token }
  end

  def send_email_validation
    begin
      Notifier.welcome(self).deliver
    rescue
      Rails.logger.error("Unable to deliver Notifier.welcome for #{self}")
    end
  end

  private

  def find_or_create_token
    create_token if token.blank?
    token
  end

  def create_token
    new_token = SecureRandom.urlsafe_base64(nil, true)
    self.update_attribute(:token, new_token)
  end
end
