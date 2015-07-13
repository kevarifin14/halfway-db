class Event < ActiveRecord::Base
  has_many :invitations
  has_many :users, through: :invitations

  default_scope { order(date: :desc) }

end
