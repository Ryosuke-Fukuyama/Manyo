class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true

  # include Searchable
  # define_like_search :title, :content, :progress

  # scope :search, -> (search_params) do
  #  return if search_params.blank?

  #   title_like(search_params[:title])
  #     .progress_is(search_params[:progress])
  #     .label_id_is(search_params[:label_id])
  # end

  scope :search_title, -> (title) {
    where("title LIKE ?", "%#{ title }%")
  }

  scope :search_status, -> (status) {
    where(progress: status)
  }

  scope :search_label, -> (label_id) {
    task_ids = Labelling.where(label_id: label_id).pluck(:task_id)
    where(id: task_ids)
  }


  # scope :title_like, -> (title) { where("title LIKE ?", "%#{title}%") if title.present? }
  # scope :progress_is, -> (progress) { where(progress: progress) if progress.present? }
  # scope :label_id_is, -> (label_id) { where(labels: { id: label_id }) if label_id.present? }
  # scope :limit_sort, -> { order(limit: :DESC) }
  # scope :priority_sort, -> { order(priority: :DESC) }
  # scope :created_at_sort, -> { order(created_at: :DESC) }

  enum progress: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
end
