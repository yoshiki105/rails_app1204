class Entry < ApplicationRecord
  belongs_to :member
  has_many :images, class_name: 'EntryImage'

  # ステータスカラムの値を定義
  STATUS_VALUES = %w[draft member_only public].freeze

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: 'public') } # 非ログイン状態でも見ることのできるエントリ
  scope :published, -> { where('status <> ?', 'draft') } # draft以外のエントリ
  scope :full, lambda { |member|
                 where('member_id = ? OR status <> ?', member.id, 'draft') # 自分が見ることのできるエントリ
               }
  scope :readable_for, ->(member) { member ? full(member) : common } # ログインの可否で見る事のできるエントリを判別する

  class << self
    # ステータスカラムを日本語化する
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end
