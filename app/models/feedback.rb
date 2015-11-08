# Subject
# First name
# Last name
# Email
# Phone Number
# Address
# Comment

class Feedback < ActiveRecord::Base
  validates_presence_of :subject
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email_address
  validates_presence_of :comment
end
