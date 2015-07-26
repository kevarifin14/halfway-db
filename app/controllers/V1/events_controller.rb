require './lib/halfway_calculator'

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
      @event.update(HalfwayCalculator.call(event: @event))
      Invitation.find_by(user: user, event: @event).update(rsvp: true)
      @event.users << event_invitees
      render json: @event
    end

    private

    def user
      User.find(params.require(:user_id))
    end

    def event_params
      params.permit(:date, :description)
    end

    def event_invitees
      event_invitees = []
      params.fetch(:users).each do |user|
        event_invitees.append(User.find(user))
      end
      event_invitees
    end
  end
end
