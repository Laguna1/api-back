class Activity < ApplicationRecord
  belongs_to :user
  has_many :trackings

  validates :item, presence: true
end
