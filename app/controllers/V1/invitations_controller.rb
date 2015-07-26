module V1
  # CRUD for invitations
  class InvitationsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def update
      @invitation = Invitation.find(params.require(:id))
      @invitation.update(invitation_params)
      render json: @invitation
    end

    private

    def invitation_params
      params.require(:invitation).permit(:rsvp)
    end
  end
end
