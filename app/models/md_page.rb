class MdPage < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end
end
