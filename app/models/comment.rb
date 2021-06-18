class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :body, presence: true, length: { maximum: 65_535 }

  default_scope -> { order(created_at: :desc) }
end
