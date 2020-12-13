class EntryImage < ApplicationRecord
  belongs_to :entry
  has_one_attached :data

  attribute :new_data

  before_save :update_data

  validates :new_data, presence: { on: :create }  # 空はNG(作成時のみ)

  validate if: :new_data do
    if new_data.respond_to?(:content_type)
      errors.add(:new_data, :invalid_image_type) unless new_data.content_type.in?(ALLOWED_CONTENT_TYPES)
    else
      errors.add(:new_data, :invalid)
    end
  end

  private

  def update_data
    self.data = new_data if new_data
  end
end
