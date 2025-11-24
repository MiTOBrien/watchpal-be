class ShowSerializer
  include JSONAPI::Serializer
  attributes :id, :show_name, :air_day, :air_time, :channel_name, :channel_number, :available_on
end
