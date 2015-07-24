module V1
  # CRUD for users
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def index
      @users = User.all
      render json: @users
    end
  end
end

# curl localhost:3000/v1/users
