class Activity < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :trackings

  validates :name, presence: true
  validates :place, presence: true
end
