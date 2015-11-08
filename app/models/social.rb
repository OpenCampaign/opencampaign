class Social < ActiveRecord::Base
  validates :name, presence: true
  validates :payload, presence: true
end
