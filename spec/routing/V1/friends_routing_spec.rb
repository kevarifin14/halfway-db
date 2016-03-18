require 'rails_helper'

RSpec.describe V1::FriendsController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/v1/users/1/friends')
        .to route_to('v1/friends#create', format: :json, user_id: '1')
    end
  end
end
