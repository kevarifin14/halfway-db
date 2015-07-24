require_relative 'membership'

# Containes a group of users
class Group < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships
end
