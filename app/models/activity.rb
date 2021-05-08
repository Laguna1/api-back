class Activity < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :place, presence: true
end
