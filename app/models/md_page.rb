class MdPage < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true

  def to_param
    slug
  end
end
