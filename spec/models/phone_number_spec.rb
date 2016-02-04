require 'active_record_helper'
require './app/models/phone_number'

RSpec.describe PhoneNumber do
  subject { described_class.create }

  before do
    allow(subject).to receive(:generate_pin).and_return('1234')
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:phone_number) }
    it { is_expected.to have_db_column(:pin) }
    it { is_expected.to have_db_column(:verified) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#generate_pin' do
    it 'generates a random pin' do
      expect(subject.generate_pin).to eq('1234')
    end
  end
end
