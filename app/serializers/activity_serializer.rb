class ActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :place, :intensity

  belongs_to :user
  has_many :trackings
end
