# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rsvp       :boolean
#
# Indexes
#
#  index_invitations_on_event_id  (event_id)
#  index_invitations_on_user_id   (user_id)
#

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
