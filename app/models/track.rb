class Track < ApplicationRecord
  belongs_to :activ

  validates :name, presence: true
  validates :distance, presence: true
  validates :duration, presence: true
  validates :repeat, presence: true
end
