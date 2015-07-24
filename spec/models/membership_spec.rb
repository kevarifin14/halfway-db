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
