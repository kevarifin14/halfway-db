require 'rails_helper'

RSpec.describe V1::UsersController do
  let!(:first_user) { create(User) }
  let!(:second_user) { create(User) }

  describe 'GET #index' do
    before { get :index }

    specify { expect(response).to be_successful }

    it 'displays all users in a json hash' do
      body = JSON.parse(response.body)

      expect(body[0].fetch('username')).to eq('user3')
      expect(body[0].fetch('email')).to eq('user3@example.com')
      expect(body[1].fetch('username')).to eq('user4')
      expect(body[1].fetch('email')).to eq('user4@example.com')
    end
  end
end
