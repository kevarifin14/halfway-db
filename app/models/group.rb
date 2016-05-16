# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_relative 'membership'

# Containes a group of users
class Group < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships
end
