class Activity < ApplicationRecord
  has_many :trackings, dependent: :destroy

  validates :item, presence: true
end
