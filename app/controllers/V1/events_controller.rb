require './lib/halfway_location_retriever'
require './app/serializers/V1/event_serializer'

module V1
  # CRUD for events
  class EventsController < ApplicationController
    def index
      @events = user.events
      render json: @events, root: 'events'
    end

    def show
      @event = event
      render json: event, serializer: V1::EventSerializer
    end

    def create
      @event = Event.create(event_params)
      @event.users << invited_users
      rsvp_user
      @event.update!(
        HalfwayLocationRetriever.call(
          event: @event,
          search_param: event_params.fetch(:search_param),
        ),
      ) if @event.all_replied?
      render json: @event
    end

    def destroy
      @event = event
      @event.delete
      render json: @event
    end

    private

    def invited_users
      [user] + event_invitees
    end

    def rsvp_user
      Invitation.find_by(user: user, event: @event).update(rsvp: true)
    end

    def event_params
      params.require(:event).permit(:search_param, :date, :description)
    end

    def event
      Event.find(params.require(:id))
    end

    def user
      User.find(params.require(:user_id))
    end

    def event_invitees
      invitees = []
      params.fetch(:users).each do |user|
        invitees << User.find(user)
      end unless params.fetch(:users).nil?
      invitees
    end
  end
end
