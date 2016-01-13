module V1
  # Serializer for events
  class EventSerializer < ActiveModel::Serializer
    attributes :id,
               :date,
               :description,
               :meeting_point,
               :address,
               :search_param,
               :friends,
               :latitude,
               :longitude,
               :image

    def friends
      object.users.map do |user|
        V1::UserSerializer.new(user, scope: scope, root: false, event: object)
      end
    end
  end
end
