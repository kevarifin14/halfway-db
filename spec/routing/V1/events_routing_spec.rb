require 'rails_helper'

RSpec.describe V1::EventsController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #index' do
      expect(get: 'v1/users/1/events')
        .to route_to('v1/events#index', user_id: '1', format: :json)
    end

    it 'routes to #create' do
      expect(post: '/v1/users/1/events')
        .to route_to('v1/events#create', user_id: '1', format: :json)
    end
  end
end
