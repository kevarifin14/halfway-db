require 'rails_helper'

RSpec.describe V1::VerificationsController do
  describe 'routing' do
    it 'routes to #update' do
      expect(put: '/v1/users/1/verification')
        .to route_to('v1/verifications#update', format: :json, user_id: '1')
    end
  end
end
