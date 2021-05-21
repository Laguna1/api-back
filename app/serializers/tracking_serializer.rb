class TrackingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :date, :distance, :duratuin, :pulse, :rate
  
  belongs_to :activity
end
