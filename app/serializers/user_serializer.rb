class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username

  has_many :activities
end
