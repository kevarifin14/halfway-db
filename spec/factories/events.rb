# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  description   :string           not null
#  date          :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  meeting_point :string
#  address       :string
#  search_param  :string           not null
#  latitude      :decimal(, )
#  longitude     :decimal(, )
#  image         :string
#

FactoryGirl.define do
  factory :event do
    description 'Event'
    date '1996-01-03'.to_datetime
    search_param 'restaurant'
  end
end
