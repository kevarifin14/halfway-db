# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  description   :string           not null
#  date          :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  meeting_point :string
#  address       :string
#  search_param  :string           not null
#  latitude      :decimal(, )
#  longitude     :decimal(, )
#  image         :string
#

require_relative 'invitation'
require_relative 'user'

# Stores event information
class Event < ActiveRecord::Base
  has_many :invitations
  has_many :users, through: :invitations

  default_scope { order(date: :asc) }

  def all_replied?
    invitations.each do |invitation|
      return false unless invitation.rsvped?
    end
    true
  end
end
