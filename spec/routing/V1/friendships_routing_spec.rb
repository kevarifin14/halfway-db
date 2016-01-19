require 'rails_helper'

RSpec.describe V1::FriendshipsController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #index' do
      expect(get: 'v1/users/1/friendships')
        .to route_to('v1/friendships#index', user_id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/v1/users/1/friendships')
        .to route_to('v1/friendships#create', user_id: '1', format: :json)
    end

    it 'routes to #destory' do
      expect(delete: '/v1/users/1/friendships')
        .to route_to('v1/friendships#destroy', user_id: '1', format: :json)
    end
  end
end
