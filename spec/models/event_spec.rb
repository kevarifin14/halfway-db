require 'rails_helper'

RSpec.describe Event do
  subject { create(described_class) }

  describe 'default_scope' do
    let!(:first) { create(described_class, date: '2015-03-01') }
    let!(:third) { create(described_class, date: '2015-05-01') }
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
    it { is_expected.to have_db_column(:longitude).of_type(:decimal) }
    it { is_expected.to have_db_column(:latitude).of_type(:decimal) }
    it { is_expected.to have_db_column(:image).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:users).through(:invitations) }
  end

  describe '#all_replied?' do
    let(:user_1) { create(User) }
    let(:user_2) { create(User) }

    before do
      subject.users << user_1
      subject.users << user_2
    end

    it 'returns false if not all have replied to event invitation' do
      Invitation.find_by(user: user_1, event: subject).update(rsvp: true)
      expect(subject.all_replied?).to eq(false)
    end

    it 'returns true if all have replied to event invitation' do
      Invitation.find_by(user: user_1, event: subject).update(rsvp: true)
      Invitation.find_by(user: user_2, event: subject).update(rsvp: false)
      expect(subject.all_replied?).to eq(true)
    end
  end
end
