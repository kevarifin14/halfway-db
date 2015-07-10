require 'rails_helper'

RSpec.describe V1::FriendshipsController do
  let(:user) { create(User) }
  let(:friend) { create(User) }

  describe 'POST #create' do
    before { post :create, user_id: user, friend_id: friend}

    it 'creates a friendship between the two users' do
      expect(user.friends).to include(friend)
      expect(friend.friends).to include(user)
    end
  end
end
