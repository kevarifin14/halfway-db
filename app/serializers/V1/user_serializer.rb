module V1
  # Serializer for events
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :avatar, :username, :email, :latitude, :longitude
  end
end
