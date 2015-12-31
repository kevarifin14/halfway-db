require 'rails_helper'

RSpec.describe V1::FriendRequestsController do
  let(:user) { create(User) }
  let(:friend) { create(User) }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token
  end

  describe 'GET #index' do
    before do
      friend.friends.append(user)
      get :index, user_id: user
    end

    let(:json) { JSON.parse(response.body) }

    it 'lists all unaccepted friend requests' do
      expect(json.fetch('requests').first).to include('id' => friend.id)
    end
  end
end
