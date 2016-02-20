require 'rails_helper'

RSpec.describe V1::LogoutsController do
  let(:user) { create(User, verified: true) }

  describe 'PUT #update' do
    before do
      request.env['HTTP_AUTHORIZATION'] = user.access_token
      put :update, user_id: user
      user.reload
    end

    it 'unverifies the user' do
      expect(user.verified).to eq(false)
    end
  end
end
