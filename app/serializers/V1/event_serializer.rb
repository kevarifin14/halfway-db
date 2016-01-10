module V1
  # Serializer for events
  class EventSerializer < ActiveModel::Serializer
    attributes :id,
               :date,
               :description,
               :meeting_point,
               :address,
               :search_param,
               :friends

    def friends
      object.users
    end
  end
end
