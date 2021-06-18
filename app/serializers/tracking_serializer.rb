class TrackingSerializer
  include JSONAPI::Serializer
  attributes :name, :distance, :duration, :repeats, :activity
end
