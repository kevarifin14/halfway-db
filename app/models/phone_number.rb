require './app/models/user'

# Stores user phone number for account verification
class PhoneNumber < ActiveRecord::Base
  belongs_to :user
end
