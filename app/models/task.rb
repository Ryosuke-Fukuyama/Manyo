class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  scope :title_search, -> (query) { where("title LIKE ?", "%#{query}%") }
  # include Searchable
  # define_like_search :title, :content, :progress
end
