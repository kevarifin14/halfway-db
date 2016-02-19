require 'rails_helper'

RSpec.describe User do
  subject { described_class.create }

  before do
    allow(subject).to receive(:generate_pin).and_return('1234')
  end

  describe 'associations' do
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:groups).through(:memberships) }

    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:events).through(:invitations) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:phone_number).of_type(:string)
        .with_options(unique: true)
    end
    it do
      is_expected.to have_db_column(:verified).of_type(:boolean)
        .with_options(default: false)
    end
    it { is_expected.to have_db_column(:pin).of_type(:string) }
    it { is_expected.to have_db_column(:access_token).of_type(:string) }
    it { is_expected.to have_db_column(:latitude).of_type(:decimal) }
    it { is_expected.to have_db_column(:longitude).of_type(:decimal) }
  end

  describe 'scopes' do
    describe 'accepted_event_invitation' do
      let(:invited_and_attending_user) { create(User) }
      let(:invited_but_not_attending_user) { create(User) }
      let(:uninvited_user) { create(User) }

      let!(:event) do
        create(
          Event,
          users: [
            invited_and_attending_user,
            invited_but_not_attending_user,
          ],
        )
      end

      before do
        Invitation.find_by(
          event: event,
          user: invited_and_attending_user,
        ).update(rsvp: true)
      end

      it 'returns users that have accepted the event invitation' do
        expect(described_class.accepted_event_invitation(event))
          .to match_array([invited_and_attending_user])
      end
    end
  end

  describe '#generate_pin' do
    it 'generates a random pin' do
      expect(subject.generate_pin).to eq('1234')
    end
  end

  describe '#verify' do
    subject { described_class.create(pin: '1234') }

    before { subject.verify(pin) }

    context 'PIN matches' do
      let(:pin) { '1234' }
      it 'verifies the phone number' do
        expect(subject.verified).to eq(true)
      end
    end

    context 'PIN does not match' do
      let(:pin) { '1232' }
      it 'does not verify the phone number' do
        expect(subject.verified).to eq(false)
      end
    end
  end
end
