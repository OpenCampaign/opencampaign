class Issue < ActiveRecord::Base
  attr_accessor :title
  attr_accessor :position

  belongs_to :issue_list
  acts_as_list scope: :issue_list
  acts_as_taggable_on :position
end
