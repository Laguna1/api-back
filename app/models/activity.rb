class Activity < ApplicationRecord
  has_many :tracks, dependent: :destroy

  validates :item, presence: true
end
