require 'rails_helper'

RSpec.describe V1::VerificationsController do
  let!(:user) { create(User) }

  before do
    allow_any_instance_of(User).to receive(:generate_pin).and_return('1234')
  end

  describe 'PUT #update' do
    before do
      put :update, user_id: user.id, verification: verification_attributes
      user.reload
    end

    let(:verification_attributes) do
      { pin: pin }
    end

    context 'correct pin' do
      let(:pin) { '1234' }
      it 'verifies the user' do
        expect(user.verified).to eq(true)
      end
    end

    context 'incorrect pin' do
      let(:pin) { '123' }
      it 'does not verify the user' do
        expect(user.verified).to eq(false)
      end
    end
  end
end
