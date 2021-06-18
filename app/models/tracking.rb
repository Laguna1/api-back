class Tracking < ApplicationRecord
  belongs_to :activity

  validates :name, presence: true
  validates :distance, presence: true
  validates :duration, presence: true
  validates :repeats, presence: true
end
