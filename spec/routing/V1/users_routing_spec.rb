require 'rails_helper'

RSpec.describe V1::UsersController do
  describe 'routing' do
    include_context 'authenticated as a User'

    it 'routes to #index' do
      expect(get: '/v1/users')
        .to route_to('v1/users#index', format: :json)
    end
  end
end
