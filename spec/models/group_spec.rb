require 'rails_helper'

RSpec.describe Group do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users).through(:memberships) }
    it { is_expected.to have_many(:memberships) }
  end
end
