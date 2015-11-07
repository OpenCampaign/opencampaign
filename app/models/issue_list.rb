class IssueList < ActiveRecord::Base
  has_many :issues, -> { order(position: :asc) }
end
