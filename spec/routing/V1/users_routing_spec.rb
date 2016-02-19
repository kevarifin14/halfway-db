require 'rails_helper'

RSpec.describe V1::UsersController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/users').to route_to('v1/users#index', format: :json)
    end

    it 'routes to #update' do
      expect(put: '/v1/users/1')
        .to route_to('v1/users#update', format: :json, id: '1')
    end
  end
end
