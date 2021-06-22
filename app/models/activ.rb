class Activ < ApplicationRecord
  belongs_to :user
  has_many :tracks, dependent: :destroy

  validates :item, presence: true
end
