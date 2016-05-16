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
# Indexes
#
#  index_invitations_on_event_id  (event_id)
#  index_invitations_on_user_id   (user_id)
#

FactoryGirl.define do
  factory :invitation do
  end
end
