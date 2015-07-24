require_relative 'user'
require_relative 'group'

# Join table for indicating user membership of a group
class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
