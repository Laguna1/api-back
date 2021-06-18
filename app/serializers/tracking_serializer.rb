class TrackingSerializer
  include JSONAPI::Serializer
  attributes :name, :distance, :duration, :repeat, :activity
end
