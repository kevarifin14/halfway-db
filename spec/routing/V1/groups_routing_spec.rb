require 'rails_helper'

RSpec.describe V1::GroupsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'v1/users/1/groups')
        .to route_to('v1/groups#index', user_id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/v1/users/1/groups')
        .to route_to('v1/groups#create', user_id: '1', format: :json)
    end
  end
end
