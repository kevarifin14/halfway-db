module V1
  # CRUD for friendships
  class FriendshipsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def index
      render json: user.friends
    end

    def create
      user.friends.append(friend)
      render json: friend
    end

    private

    def user
      User.find(params.require(:user_id))
    end

    def friend
      User.find(params.require(:friend_id))
    end
  end
end
