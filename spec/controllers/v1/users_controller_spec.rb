require 'rails_helper'
require 'rack/test'

RSpec.describe V1::UsersController do
  let!(:user) { create(User, latitude: 15, longitude: 12) }
  let!(:first_user) { create(User) }
  let!(:second_user) { create(User) }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token
  end

  describe 'GET #index' do
    before { get :index }

    let(:users_json) do
      {
        'users' => [
          {
            'id' => User.first.id,
            'phone_number' => '4088334900',
            'verified' => false,
            'access_token' => User.first.access_token,
            'latitude' => '15.0',
            'longitude' => '12.0',
          },
          {
            'id' => User.second.id,
            'phone_number' => '4088334900',
            'verified' => false,
            'access_token' => User.second.access_token,
            'latitude' => '15.0',
            'longitude' => '15.5',
          },
          {
            'id' => User.third.id,
            'phone_number' => '4088334900',
            'verified' => false,
            'access_token' => User.third.access_token,
            'latitude' => '15.0',
            'longitude' => '15.5',
          },
        ],
      }
    end

    specify { expect(response).to be_successful }

    it 'displays all users in a json hash' do
      expect(JSON(response.body)).to eq(users_json)
    end
  end

  describe 'PUT #update' do
    let(:updated_params) do
      attributes_for(User).merge(
        latitude: new_latitude,
        longitude: new_longitude,
      )
    end
    let(:new_latitude) { 4.0 }
    let(:new_longitude) { 2.0 }

    def put_update
      put :update, id: user, user: updated_params
    end

    it 'does not create a new_user' do
      expect { put_update }.not_to change(User, :count)
    end

    let(:user_json) do
      {
        'user' => {
          'id' => user.id,
          'phone_number' => user.phone_number,
          'verified' => user.verified,
          'access_token' => user.access_token,
          'latitude' => new_latitude.to_s,
          'longitude' => new_longitude.to_s,
        },
      }
    end

    it 'updates user attributes' do
      put_update
      expect(JSON.parse(response.body)).to eq(user_json)
    end
  end
end
