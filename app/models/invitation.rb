require_relative 'user'

# Join table for a user to be included as a part of an event
class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
