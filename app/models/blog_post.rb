class BlogPost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  default_scope { order(position: :asc) }
end