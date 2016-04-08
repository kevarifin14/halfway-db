require 'rails_helper'
require './app/models/invitation'

RSpec.describe Invitation do
  subject { create(described_class) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_db_index(:user_id) }

    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_db_index(:event_id) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:rsvp).of_type(:boolean)
    end
  end

  describe '#rsvped?' do
    it 'returns false if invitation has no rsvp' do
      expect(subject.rsvped?).to eq(false)
    end

    it 'returns true if invitation has an rsvp' do
      subject.update(rsvp: true)
      expect(subject.rsvped?).to eq(true)
    end
  end
end
