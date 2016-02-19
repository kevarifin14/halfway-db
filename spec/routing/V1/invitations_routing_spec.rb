require 'rails_helper'

RSpec.describe V1::InvitationsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'v1/events/1/invitations')
        .to route_to('v1/invitations#index', event_id: '1', format: :json)
    end

    it 'routes to #update' do
      expect(put: 'v1/invitations/1')
        .to route_to('v1/invitations#update', id: '1', format: :json)
    end
  end
end
