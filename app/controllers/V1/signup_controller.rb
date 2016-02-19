module V1
  # CRUD for signing up
  class SignupController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.create(params_for_user)
      @user.generate_pin
      @user.send_pin
      render json: @user, serializer: V1::UserSerializer, root: 'user'
    end

    private

    def params_for_user
      params.require(:user).permit(
        :phone_number,
        :latitude,
        :longitude,
      )
    end
  end
end
