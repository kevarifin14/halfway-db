require 'active_record_helper'
require './app/models/event'

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
    it { is_expected.to have_db_column(:description).with_options(null: false) }
    it { is_expected.to have_db_column(:date).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:users).through(:invitations) }
  end
end
