class Tag < ActiveRecord::Base
  has_many :posts
  has_many :tags_posts
  has_many :posts, through: :tags_posts

  validates :name, presence: true
end
