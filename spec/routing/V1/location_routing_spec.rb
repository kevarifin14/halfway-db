require 'rails_helper'

RSpec.describe V1::LocationController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #create' do
      expect(post: '/v1/users/1/location')
        .to route_to('v1/location#create', user_id: '1', format: :json)
    end
  end
end
