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

require 'active_record_helper'
require './app/models/membership'

RSpec.describe Membership do
  describe 'associations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to have_db_index(:group_id) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:user_id) }
  end
end
