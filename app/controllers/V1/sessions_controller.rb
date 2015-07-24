require './app/serializers/V1/sessions_serializer'

module V1
  # CRUD for sessions
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.find_for_database_authentication(
        username: params.fetch(:username),
      )
      return invalid_login_attempt unless @user

      if @user.valid_password?(params.fetch(:password))
        sign_in :user, @user
        render json: @user, serializer: V1::SessionsSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: { error: t('sessions_controller.invalid_login_attempt') },
             status: :unprocessable_entity
    end
  end
end
