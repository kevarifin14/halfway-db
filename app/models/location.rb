require_relative 'user'

# Stores current latitude and longitude of a user
class Location < ActiveRecord::Base
  belongs_to :user
end
