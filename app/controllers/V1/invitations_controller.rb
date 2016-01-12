require './lib/halfway_location_retriever'

module V1
  # CRUD for invitations
  class InvitationsController < ApplicationController
    def index
      @invitations = event.invitations
      render json: @invitations, root: 'invitations'
    end

    def update
      @invitation = Invitation.find(params.require(:id))
      @invitation.update!(invitation_params)
      update_halfway_location
    end

    private

    def invitation_params
      params.require(:invitation).permit(:rsvp)
    end

    def event
      Event.find(event_id)
    end

    def event_id
      params.require(:event_id)
    end

    def update_halfway_location
      @invitation.event.update(
        HalfwayLocationRetriever.call(
          event: @invitation.event,
          search_param: @invitation.event.search_param,
        )
      )
    end
  end
end
