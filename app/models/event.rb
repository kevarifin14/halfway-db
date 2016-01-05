require_relative 'invitation'
require_relative 'user'

# Stores event information
class Event < ActiveRecord::Base
  has_many :invitations
  has_many :users, through: :invitations

  default_scope { order(date: :asc) }
end
