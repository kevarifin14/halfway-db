require 'rails_helper'

RSpec.describe V1::UsersController do
  let!(:first_user) { create(User) }
  let!(:second_user) { create(User) }

  describe 'GET #index' do
    before { get :index }

    specify { expect(response).to be_successful }

    it 'displays all users in a json hash' do
      body = JSON.parse(response.body)

      expect(body[0]).to include('username' => first_user.username)
      expect(body[0]).to include('email' => first_user.email)
      expect(body[1]).to include('username' => second_user.username)
      expect(body[1]).to include('email' => second_user.email)
    end
  end
end
