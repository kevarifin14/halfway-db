module V1
  # CRUD for sessions
  class LoginController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.find_by(phone_number: phone_number)
      return invalid_login_attempt unless @user
      validate_user
      render json: @user, root: 'user'
    end

    private

    def validate_user
      @user.generate_pin
      @user.send_pin
    end

    def phone_number
      user_attributes.fetch(:phone_number)
    end

    def user_attributes
      params.require(:user).permit(:phone_number)
    end

    def invalid_login_attempt
      warden.custom_failure!
      render json: { error: t('login_controller.invalid_login_attempt') },
             status: :unprocessable_entity
    end
  end
end
