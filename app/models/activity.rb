class Activity < ApplicationRecord
  belongs_to :user
  has_many :trackings

  validates :name, presence: true
  validates :place, presence: true
end
