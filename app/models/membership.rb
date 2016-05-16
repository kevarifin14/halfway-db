# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_relative 'user'
require_relative 'group'

# Join table for indicating user membership of a group
class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
