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

    specify { expect(response).to be_successful }

    it 'displays all users in a json hash' do
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
      expect(body.fetch('user')).to include('username' => user.username)
      expect(body.fetch('user')).to include('email' => user.email)
      expect(body.fetch('user')).to include('latitude' => user.latitude.to_s)
      expect(body.fetch('user')).to include('longitude' => user.longitude.to_s)
    end

    context 'updating avatars' do
      let(:fixture_file_path) do
        Rails.root.join('spec', 'fixtures', 'avatar.png')
      end
      let(:avatar_params) do
        { avatar: fixture_file_upload('avatar.png') }
      end
      # it 'allows users to update their avatar' do
      #   put :update,
      #       id: user,
      #       user: updated_params,
      #       avatar: fixture_file_upload('avatar.png')
      #   user.reload
      # end
    end
  end
end
