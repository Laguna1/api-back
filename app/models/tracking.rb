class Tracking < ApplicationRecord
  belongs_to :activity

  validates :date, presence: true
  # validates :rate, presence: true
  validates :distance, presence: true
end
