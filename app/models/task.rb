class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  # scope :sorted, -> {order(limit: :desc)}
end
