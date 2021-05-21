class TrackingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :date, :distance, :duration, :pulse, :rate, :activity_id

  belongs_to :activity, serializer: ActivitySerializer
end
