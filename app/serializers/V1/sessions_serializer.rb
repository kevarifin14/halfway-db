module V1
  # Serializes a session for security
  class SessionsSerializer < ActiveModel::Serializer
    attributes :email, :token_type, :user_id, :access_token, :username

    def user_id
      object.id
    end

    def token_type
      'Bearer'
    end
  end
end
