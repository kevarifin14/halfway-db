require './lib/halfway_location_retriever'

module V1
  # CRUD for events
  class EventsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def index
      render json: user.events
    end

    def create
      @event = Event.create(event_params)
      @event.users << user
      rsvp_user
      @event.users << event_invitees
      @event.update(HalfwayLocationRetriever
        .call(
          event: @event,
          search_param: search_param,
        ))
      render json: @event
    end

    def destroy
      @event = event
      @event.delete
      render json: @event
    end

    private

    def rsvp_user
      Invitation.find_by(user: user, event: @event).update(rsvp: true)
    end

    def event_params
      params.permit(:date, :description, :search_param)
    end

    def search_param
      params.require(:search_param)
    end

    def event
      Event.find(params.require(:id))
    end

    def user
      User.find(params.require(:user_id))
    end

    def event_invitees
      invitees = []
      params.fetch(:users).map do |user|
        invitees.append(User.find(user))
      end
    end
  end
end
