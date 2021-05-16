class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  # include Searchable
  # define_like_search :title, :content, :progress

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .progress_is.(search_params[:progress])
  end

  scope :id_sort, -> { order(id: :DESC) }
  scope :limit_sort, -> { order(limit: :DESC) }
  scope :title_like, -> (title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :progress_is, -> (progress) { where(progress: progress) if progress.present? }
end
