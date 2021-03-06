module V1
  # CRUD for user phone number verification
  class VerificationsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def update
      user.verify(pin)
      render json: user, serializer: V1::UserSerializer, root: 'user'
    end

    private

    def pin
      params.require(:verification).permit(:pin).fetch(:pin)
    end

    def user
      User.find(params.require(:user_id))
    end
  end
end
