require 'rails_helper'

RSpec.describe V1::FriendRequestsController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #index' do
      expect(get: 'v1/users/1/friend_requests')
        .to route_to('v1/friend_requests#index', user_id: '1', format: :json)
    end
  end
end
