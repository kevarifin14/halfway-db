module V1
  # CRUD for friend requests
  class FriendRequestsController < ApplicationController
    def index
      @friend_requests = User.friend_requests(user)
      render json: @friend_requests, root: 'requests'
    end

    private

    def user
      User.find(params.require(:user_id))
    end
  end
end
