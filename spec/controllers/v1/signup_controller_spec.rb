require 'rails_helper'

RSpec.describe V1::SignupController do
  describe 'POST #create' do
    before do
      allow_any_instance_of(User).to receive(:twilio_client)
        .and_return('client')
      allow_any_instance_of(User).to receive(:send_pin)
        .and_return('client')
      allow_any_instance_of(User).to receive(:generate_pin)
        .and_return('1234')
    end

    def post_create
      post :create,
           user: user_attributes
    end

    let(:user_attributes) do
      {
        phone_number: '6502554349',
        longitude: 15.0,
        latitude: 15.0,
      }
    end

    let(:user_json) do
      {
        'user' => {
          'id' => User.last.id,
          'phone_number' => '6502554349',
          'verified' => false,
          'access_token' => User.last.access_token,
          'latitude' => '15.0',
          'longitude' => '15.0',
        },
      }
    end

    it 'creates a new user' do
      expect { post_create }.to change(User, :count).by(1)
    end

    it 'renders json for the user' do
      post_create
      expect(JSON.parse(response.body)).to eq(user_json)
    end
  end
end
