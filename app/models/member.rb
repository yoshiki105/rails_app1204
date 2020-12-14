class Member < ApplicationRecord
  has_secure_password

  # 1対多の関連付け
  has_many :entries, dependent: :destroy

  # 多対多の関連付け
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry

  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  attr_accessor :current_password

  before_save :update_profile_picture

  # バリデーション
  validates :number,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than: 100,
              allow_blank: true
            },
            uniqueness: true

  validates :name,
            presence: true,
            format: {
              with: /\A[A-Za-z][A-Za-z0-9]*\z/,
              allow_blank: true,
              message: :invalid_member_name
            },
            length: { minimum: 2, maximum: 20, allow_blank: true },
            uniqueness: { case_sensitive: false }

  validates :full_name, presence: true, length: { maximum: 20 }
  validates :email, email: { allow_blank: true }
  validates :password, presence: { if: :current_password }

  validate if: :new_profile_picture do # nilでもfalseでもない時
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        # ファイル形式が正しくない時
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      # フォームからアップロードされたデータではない時
      errors.add(:new_profile_picture, :invalid)
    end
  end

  # プロフィール画像更新（追加と削除）
  def update_profile_picture
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      profile_picture.purge
    end
  end

  # いいねできるかどうか調べる
  def votable_for?(entry)
    entry && entry.member != self && !votes.exists?(entry_id: entry.id)
  end

  # クラスメソッド
  class << self
    def search(query)
      rel = order('number')
      if query.present?
        rel = rel.where('name LIKE ? OR full_name LIKE ?',
                        "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
