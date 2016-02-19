module V1
  # Serializer for events
  class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :phone_number,
               :verified,
               :access_token,
               :latitude,
               :longitude
  end
end
