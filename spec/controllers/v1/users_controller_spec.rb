require 'rails_helper'

RSpec.describe V1::UsersController do
  let!(:user) { create(User, latitude: 15, longitude: 12) }
  let!(:first_user) { create(User) }
  let!(:second_user) { create(User) }

  describe 'GET #index' do
    before { get :index }

    specify { expect(response).to be_successful }

    it 'displays all users in a json hash' do
      body = JSON.parse(response.body)

      expect(body[1]).to include('username' => first_user.username)
      expect(body[1]).to include('email' => first_user.email)
      expect(body[2]).to include('username' => second_user.username)
      expect(body[2]).to include('email' => second_user.email)
    end
  end

  describe 'PUT #update' do
    let(:updated_params) do
      attributes_for(User).merge(
        latitude: new_latitude,
        longitude: new_longitude,
      )
    end
    let(:new_latitude) { 4 }
    let(:new_longitude) { 2 }

    def put_update
      put :update, id: user, user: updated_params
    end

    it 'does not create a new_user' do
      expect { put_update }.not_to change(User, :count)
    end

    it 'updates user attributes' do
      put_update
      user.reload
      expect(user.latitude).to eq(new_latitude)
      expect(user.longitude).to eq(new_longitude)
    end

    it 'displays the update user in a json hash' do
      put_update
      user.reload
      body = JSON.parse(response.body)

      expect(body).to include('username' => user.username)
      expect(body).to include('email' => user.email)
      expect(body).to include('latitude' => user.latitude.to_s)
      expect(body).to include('longitude' => user.longitude.to_s)
    end
  end
end
