module V1
  class VerificationsController < ApplicationController
    def update
      user.verify(pin)
    end

    private

    def pin
      params.require(:verification).permit(:pin).fetch(:pin)
    end

    def user
      User.find(params.require(:user_id))
    end
  end
end
