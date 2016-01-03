module V1
  # CRUD for users
  class UsersController < ApplicationController
    # skip_before_action :authenticate_user_from_token!

    def index
      @users = User.all
      render json: @users
    end

    def update
      @user = User.find(params.require(:id))
      @user.update!(user_params)
      if params.include?(:avatar)
        @user.update!(avatar: params.require(:avatar))
      end
      @user.reload
      render json: @user
    end

    private

    def user_params
      params.require(:user).permit(:longitude, :latitude)
    end
  end
end
