module V1
  # CRUD for location
  class LocationController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @location = user.create_location(location_params)
      render json: @location
    end

    private

    def user
      User.find(params.require(:user_id))
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude)
    end
  end
end
