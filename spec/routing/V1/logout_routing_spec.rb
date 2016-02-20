require 'rails_helper'

RSpec.describe V1::LogoutsController do
  describe 'routing' do
    it 'routes to #update' do
      expect(put: '/v1/users/1/logout')
        .to route_to('v1/logouts#update', format: :json, user_id: '1')
    end
  end
end
