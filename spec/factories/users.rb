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

FactoryGirl.define do
  factory :user do
    phone_number '4088334900'
    verified false
    pin '1234'
    latitude 15.0
    longitude 15.5
  end
end
