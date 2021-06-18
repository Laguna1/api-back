class Activity < ApplicationRecord
  belongs_to :user
  has_many :trackings, dependent: :destroy

  validates :item, presence: true
end
