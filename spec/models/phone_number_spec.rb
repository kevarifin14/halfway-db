require 'active_record_helper'
require './app/models/phone_number'

RSpec.describe PhoneNumber do
  describe 'columns' do
    it { is_expected.to have_db_column(:phone_number) }
    it { is_expected.to have_db_column(:pin) }
    it { is_expected.to have_db_column(:verified) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
