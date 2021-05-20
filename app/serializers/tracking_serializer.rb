class TrackingSerializer < ActiveModel::Serializer
  attributes :id, :date, :distance, :duration, :pulse, :calories, :rate

  belongs_to :activity
end
