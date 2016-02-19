require 'rails_helper'

RSpec.describe V1::EventsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'v1/users/1/events')
        .to route_to('v1/events#index', user_id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/v1/users/1/events')
        .to route_to('v1/events#create', user_id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: 'v1/events/1')
        .to route_to('v1/events#destroy', id: '1', format: :json)
    end

    it 'routes to #show' do
      expect(get: 'v1/events/1')
        .to route_to('v1/events#show', id: '1', format: :json)
    end
  end
end
