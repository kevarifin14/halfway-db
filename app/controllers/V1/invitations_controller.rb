require './lib/halfway_location_retriever'

module V1
  # CRUD for invitations
  class InvitationsController < ApplicationController
    def update
      @invitation = Invitation.find(params.require(:id))
      @invitation.update(invitation_params)
      update_halfway_location
    end

    private

    def invitation_params
      params.require(:invitation).permit(:rsvp)
    end

    def update_halfway_location
      event.update(
        HalfwayLocationRetriever.call(
          event: event,
          search_param: event.search_param,
        )
      )
    end

    def event
      @invitation.event
    end
  end
end
