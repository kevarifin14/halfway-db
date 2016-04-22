require './lib/halfway_location_retriever'

module V1
  # CRUD for invitations
  class InvitationsController < ApplicationController
    def index
      @invitations = event.invitations
      render json: @invitations, root: 'invitations'
    end

    def show
      @invitation = Invitation.find(invitation_id)
      render json: @invitation, root: 'invitation'
    end

    def update
      @invitation = Invitation.find(params.require(:id))
      @invitation.update!(invitation_params)
      render json: @invitation, root: 'invitations'
      update_halfway_location if @invitation.event.all_replied?
    end

    private

    def invitation_id
      params.fetch(:id)
    end

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
        ),
      )
    end
  end
end
