require 'rails_helper'

RSpec.describe Location do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:latitude).of_type(:float)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:longitude).of_type(:float)
        .with_options(null: false)
    end
  end
end
