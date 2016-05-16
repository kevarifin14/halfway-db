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

FactoryGirl.define do
  factory :invitation do
  end
end
