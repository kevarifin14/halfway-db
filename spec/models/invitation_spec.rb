require 'rails_helper'

RSpec.describe Invitation do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:user_id) }

    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_db_index(:event_id) }

  end
end
