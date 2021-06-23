class TrackSerializer
  include JSONAPI::Serializer
  attributes :name, :distance, :duration, :repeat, :activ
end
