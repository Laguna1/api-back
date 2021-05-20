class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :place, :intensity

  belongs_to :user
  has_many :trackings
end
