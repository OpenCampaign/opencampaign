class Issue < ActiveRecord::Base
  acts_as_taggable
  validates_presence_of :title
  validates_presence_of :opinion
end
