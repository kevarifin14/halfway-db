module V1
  class FriendshipsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      user.friends.append(friend)
      friend.friends.append(user)
      render json: user.friends
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
