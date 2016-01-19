require 'rails_helper'

RSpec.describe V1::FriendshipsController do
  let(:user) { create(User) }
  let(:friend) { create(User) }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token
  end

  describe 'GET #index' do
    before do
      user.friends.append(friend)
      friend.friends.append(user)
      get :index, user_id: user
    end

    let(:json) { JSON.parse(response.body) }

    it 'lists all the friends for a specific user' do
      expect(json.fetch('friendships').first).to include('id' => friend.id)
    end

    let(:enemy) { create(User) }

    it 'does not list users that are not reciprocated friends' do
      enemy.friends.append(user)
      expect(json.fetch('friendships').first).not_to include('id' => enemy.id)
    end
  end

  describe 'POST #create' do
    before { post :create, user_id: user, friend_id: friend }

    it 'creates a friendship between the two users' do
      expect(user.friends).to include(friend)
      expect(friend.friends).not_to include(user)
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.friends.append(friend)
      friend.friends.append(user)
      user.reload
      friend.reload
      delete :destroy, user_id: user, friend_id: friend
    end

    it 'deletes friendship between the two users' do
      expect(user.friends).not_to include(friend)
      expect(friend.friends).not_to include(user)
    end
  end
end
