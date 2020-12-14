class Vote < ApplicationRecord
  belongs_to :entry
  belongs_to :member

  validate do
    errors.add(:base, :invalid) unless member && member.votable_for?(entry)
  end
end
