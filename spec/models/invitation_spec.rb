require 'active_record_helper'
require './app/models/invitation'

RSpec.describe Invitation do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:user_id) }

    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_db_index(:event_id) }
  end

  describe 'columns' do
    it do is_expected.to have_db_column(:rsvp).of_type(:boolean).with_options(
        default: false,
        null: false,
      )
    end
  end
end

