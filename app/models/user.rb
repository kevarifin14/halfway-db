require 'devise'
require 'devise/orm/active_record'
require_relative 'membership'
require_relative 'event'

# Basic user class that holds user information
class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  after_create :update_access_token!

  has_attached_file :avatar,
                    styles: {
                      medium: '300x300>',
                      thumb: '100x100>'
                    },
                    default_url: '/images/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :username, presence: true
  validates :email, presence: true

  has_and_belongs_to_many :friends,
                          class_name: 'User',
                          join_table: :friendships,
                          foreign_key: :user_id,
                          association_foreign_key: :friend_user_id
  has_many :memberships
  has_many :groups, through: :memberships

  has_many :invitations
  has_many :events, through: :invitations

  scope(:accepted_event_invitation, lambda do |event|
    event.invitations.where(rsvp: true).map(&:user)
  end)

  scope(:reciprocated_friends, lambda do |user|
    find_by(username: user.username).friends.select do |friend|
      friend.friends.exists?(user.id)
    end
  end)

  scope(:friend_requests, lambda do |current_user|
    all.select do |user|
      !current_user.friends.include?(user) and
        user.friends.include?(current_user)
    end
  end)

  private

  def update_access_token!
    self.access_token = "#{id}:#{Devise.friendly_token}"
    save
  end
end
