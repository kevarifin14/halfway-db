module V1
  # CRUD to logout
  class LogoutsController < ApplicationController
    def update
      user.update!(verified: false)
    end

    private

    def user
      User.find(params.require(:user_id))
    end
  end
end
