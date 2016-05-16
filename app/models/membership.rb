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
# Indexes
#
#  index_memberships_on_group_id  (group_id)
#  index_memberships_on_user_id   (user_id)
#

require_relative 'user'
require_relative 'group'

# Join table for indicating user membership of a group
class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
