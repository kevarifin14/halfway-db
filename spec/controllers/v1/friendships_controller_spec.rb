require 'rails_helper'

RSpec.describe V1::FriendshipsController do
  let(:user) { create(User) }
  let(:friend) { create(User) }

  describe 'GET #index' do
    before do
      user.friends.append(friend)
      get :index, user_id: user
    end

    it 'lists all the friends for a specific user' do
      expect(user.friends).to eq([friend])
    end

    let(:enemy) { create(User) }

    it 'does not list users that are not friends' do
      expect(user.friends).not_to include(enemy)
    end
  end

  describe 'POST #create' do
    before { post :create, user_id: user, friend_id: friend }

    it 'creates a friendship between the two users' do
      expect(user.friends).to include(friend)
      expect(friend.friends).not_to include(user)
    end
  end
end
