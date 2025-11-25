class ShowSerializer
  include JSONAPI::Serializer
  attributes :id, :show_name, :air_day, :channel_name, :channel_number, :available_on

  attribute :air_time do |object|
    object.air_time&.strftime("%-I:%M %p") # e.g. "8:00 PM"
  end
end
