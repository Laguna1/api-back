class ActivitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :place, :intensity, :user_id

  belongs_to :user
  has_many :trackings
end
