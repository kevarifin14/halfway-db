require './lib/halfway_calculator'

module V1
  # CRUD for invitations
  class InvitationsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def update
      @invitation = Invitation.find(params.require(:id))
      @invitation.update(invitation_params)
      update_halfway_location
      render json: @invitation
    end

    private

    def invitation_params
      params.require(:invitation).permit(:rsvp)
    end

    def update_halfway_location
      event.update(HalfwayCalculator.call(event: event))
    end

    def event
      @invitation.event
    end
  end
end
