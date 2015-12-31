require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:friends).class_name('User') }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:groups).through(:memberships) }
    it { is_expected.to have_many(:events).through(:invitations) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(
          default: '',
          null: false,
        )
    end

    it do
      is_expected.to have_db_column(:latitude).of_type(:decimal)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:longitude).of_type(:decimal)
        .with_options(null: false)
    end

    it do
      is_expected.to have_db_column(:username).of_type(:string)
        .with_options(
          default: '',
          null: false,
        )
    end
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

    describe 'reciprocated_friends' do
      let(:user_1) { create(User) }
      let(:user_2) { create(User) }
      let(:user_3) { create(User) }

      before do
        add_friend(user_3, user_2)
        add_friend(user_2, user_1)
        add_friend(user_1, user_2)
        add_friend(user_1, user_3)
      end

      def add_friend(user, friend)
        user.friends.append(friend)
      end

      it 'returns only users that have reciprocated friending' do
        expect(described_class.reciprocated_friends(user_1))
          .to eq([user_2])
      end
    end

    describe 'friend_requests' do
      let(:user_1) { create(User) }
      let(:user_2) { create(User) }
      let(:user_3) { create(User) }

      before do
        add_friend(user_3, user_1)
        add_friend(user_2, user_1)
        add_friend(user_1, user_2)
      end

      def add_friend(user, friend)
        user.friends.append(friend)
      end

      it 'returns users with unaccepted friend requests' do
        expect(described_class.friend_requests(user_1))
          .to eq([user_3])
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
  end
end
