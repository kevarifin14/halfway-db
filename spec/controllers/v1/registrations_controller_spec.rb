require 'rails_helper'

RSpec.describe V1::RegistrationsController do
  describe 'POST #create' do
    def post_create
      post :create,
           email: email,
           username: username,
           password: password,
           password_confirmation: password,
           longitude: longitude,
           latitude: latitude
    end

    let(:email) { 'user@foo.com' }
    let(:username) { 'user' }
    let(:password) { 'password' }
    let(:longitude) { 69.0 }
    let(:latitude) { 54.0 }
    let(:user) { User.last }

    it 'creates a new user' do
      expect { post_create }.to change(User, :count).by(1)
    end

    it 'renders json for the user' do
      post_create
      expect(response.body).to eq(
        "{\"email\":\"#{user.email}\",\"token_type\":\"Bearer\","\
        "\"user_id\":#{user.id},"\
        "\"access_token\":\"#{user.access_token}\","\
        "\"username\":\"#{user.username}\","\
        "\"longitude\":\"69.0\","\
        "\"latitude\":\"54.0\","\
        "\"avatar\":\""\
        "https://s3-us-west-1.amazonaws.com/halfway/unknown.png\"}",
      )
    end
  end
end
