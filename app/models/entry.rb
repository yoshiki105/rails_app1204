class Entry < ApplicationRecord
  belongs_to :member

  # ステータスカラムの値を定義
  STATUS_VALUES = %w[draft follower_only public].freeze

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }
end
