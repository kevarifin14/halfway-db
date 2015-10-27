# Serializer for events
class EventSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :meeting_point, :address, :search_param
end
