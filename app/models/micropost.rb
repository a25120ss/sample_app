class Micropost < ApplicationRecord
  belongs_to :user
  # 降順
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
