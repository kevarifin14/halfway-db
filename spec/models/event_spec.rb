require 'rails_helper'

RSpec.describe Event do
  describe 'default_scope' do
    let!(:third) { create(described_class, date: '2015-03-01') }
    let!(:first) { create(described_class, date: '2015-05-01') }
    let!(:second) { create(described_class, date: '2015-04-01') }

    it 'orders them chronologically' do
      expect(described_class.all).to eq([first, second, third])
    end
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:description).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:date).of_type(:datetime)
        .with_options(null: false)
    end
    it { is_expected.to have_db_column(:meeting_point).of_type(:string) }
    it { is_expected.to have_db_column(:address).of_type(:string) }
    it do
      is_expected.to have_db_column(:search_param).of_type(:string)
        .with_options(null: false)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:users).through(:invitations) }
  end
end
