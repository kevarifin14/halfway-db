module V1
  # CRUD for friendships
  class FriendshipsController < ApplicationController
    def index
      render json: User.reciprocated_friends(user)
    end

    def create
      user.friends.append(friend)
      render json: friend
    end

    def destroy
      user.friends.delete(friend)
      friend.friends.delete(user)
      user.reload
      friend.reload
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
