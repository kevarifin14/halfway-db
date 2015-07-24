require './app/serializers/V1/sessions_serializer'

module V1
  # CRUD for registration
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.create(params_for_user)
      render json: @user, serializer: V1::SessionsSerializer, root: nil
    end

    private

    def params_for_user
      {
        email: params.fetch(:email),
        username: params.fetch(:username),
        password: params.fetch(:password),
        password_confirmation: params.fetch(:password_confirmation),
      }
    end
  end
end
