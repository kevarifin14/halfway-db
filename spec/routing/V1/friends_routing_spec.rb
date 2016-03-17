require 'rails_helper'

RSpec.describe V1::FriendsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/users/1/friends')
        .to route_to('v1/friends#index', format: :json, user_id: '1')
    end
  end
end
