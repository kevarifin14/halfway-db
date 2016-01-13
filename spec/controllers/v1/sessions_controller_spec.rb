require 'rails_helper'

RSpec.describe V1::SessionsController do
  let!(:user) do
    create(
      User,
      username: 'user',
      password: 'password',
      access_token: 'access_token',
    )
  end

  let(:invalid_message) do
    "{\"error\":\"translation missing: "\
    "en.sessions_controller.invalid_login_attempt\"}"
  end

  let(:user_json) do
    "{\"email\":\"#{user.email}\",\"token_type\":\"Bearer\","\
    "\"user_id\":#{user.id},"\
    "\"access_token\":\"#{user.access_token}\","\
    "\"username\":\"#{user.username}\","\
    "\"longitude\":\"15.0\","\
    "\"latitude\":\"15.0\","\
    "\"avatar\":\"https://s3-us-west-1.amazonaws.com/halfway/unknown.png\"}"
  end

  describe 'POST #create' do
    before do
      post_create
    end

    def post_create
      post :create, username: username, password: password
    end

    context 'with valid parameters' do
      let(:username) { 'user' }
      let(:password) { 'password' }

      it 'signs in the user' do
        expect(warden.user).to eq(user)
      end

      it 'renders json of user information' do
        expect(response.body).to eq(user_json)
      end
    end

    context 'with invalid username' do
      let(:username) { 'invalid_username' }
      let(:password) { 'password' }

      it 'returns an invalid login attempt' do
        expect(response.body).to eq(invalid_message)
      end
    end

    context 'with invalid password' do
      let(:username) { 'user' }
      let(:password) { 'invalid_password' }

      it 'returns an invalid login attempt' do
        expect(response.body).to eq(invalid_message)
      end
    end
  end
end
