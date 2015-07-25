require 'rails_helper'

RSpec.describe V1::InvitationsController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #update' do
      expect(put: 'v1/invitations/1')
        .to route_to('v1/invitations#update', id: '1', format: :json)
    end
  end
end
