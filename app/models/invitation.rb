require_relative 'user'
require './app/models/event'

# Join table for a user to be included as a part of an event
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def rsvped?
    return true unless rsvp.nil?
    false
  end
end
