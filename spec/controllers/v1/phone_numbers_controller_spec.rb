require 'rails_helper'

RSpec.describe V1::PhoneNumbersController do
  let!(:phone_number) do
    create(PhoneNumber, phone_number: '4083662347', pin: '1234')
  end

  describe 'POST #verify' do
    before do
      post :verify,
           hidden_phone_number: '4083662347',
           pin_number: '1234'
      phone_number.reload
    end

    it 'verifies the phone number' do
      expect(phone_number.verified).to eq(true)
    end
  end
end
