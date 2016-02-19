require 'rails_helper'

RSpec.describe V1::LoginController do
  let!(:user) do
    create(
      User,
      phone_number: '6502554349',
      verified: false,
      pin: '1234',
      access_token: '1234',
      latitude: 15.0,
      longitude: 15.0,
    )
  end

  let(:invalid_message) do
    {
      'error' =>
        'translation missing: en.login_controller.invalid_login_attempt',
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

  describe 'POST #create' do
    before do
      allow_any_instance_of(User).to receive(:twilio_client)
        .and_return('client')
      allow_any_instance_of(User).to receive(:send_pin)
        .and_return('sent pin')
      post_create
    end

    def post_create
      post :create, user: user_attributes
    end

    let(:user_attributes) { { phone_number: phone_number } }

    context 'with valid parameters' do
      let(:phone_number) { '6502554349' }

      it 'renders json of user information' do
        expect(user.twilio_client).to eq('client')
        expect(JSON.parse(response.body)).to eq(user_json)
      end
    end

    context 'with invalid phone number' do
      let(:phone_number) { '4082554349' }

      it 'returns an invalid login attempt' do
        expect(JSON.parse(response.body)).to eq(invalid_message)
      end
    end
  end
end
