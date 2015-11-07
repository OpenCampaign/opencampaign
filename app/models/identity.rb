class Identity < ActiveRecord::Base
  belongs_to :user
  has_one :basic_auth

  validates :provider, :uid, :email, presence: true
  validates_uniqueness_of :uid, scope: :provider
  validates_uniqueness_of :username, scope: :provider
  validates_uniqueness_of :email, scope: :provider
  validates_associated :user

end
