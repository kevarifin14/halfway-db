# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  phone_number :string
#  pin          :string
#  verified     :boolean          default(FALSE)
#  access_token :string
#  longitude    :decimal(, )
#  latitude     :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  username     :string
#

# User class for authentication
class User < ActiveRecord::Base
  after_create :update_access_token!

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :invitations
  has_many :events, through: :invitations

  scope(:accepted_event_invitation, lambda do |event|
    event.invitations.where(rsvp: true).map(&:user)
  end)

  def generate_pin
    self.pin = rand(0000..9999).to_s.rjust(4, '0')
    save
  end

  def twilio_client
    Twilio::REST::Client
      .new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_pin
    twilio_client.messages.create(
      to: phone_number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your PIN is #{pin}",
    )
  end

  def verify(entered_pin)
    update(verified: pin == entered_pin)
  end

  def update_access_token!
    self.access_token = "#{id}:#{Devise.friendly_token}"
    save
  end
end
