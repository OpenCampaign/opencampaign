class VolunteerRegistration < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :interests
  validates_presence_of :volunteer_profile
end
