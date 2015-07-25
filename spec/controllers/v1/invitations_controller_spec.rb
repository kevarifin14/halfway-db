require 'rails_helper'

RSpec.describe V1::InvitationsController do
  let!(:invitation) { create(Invitation) }
  let(:invitation_params) { attributes_for(Invitation).merge(rsvp: true) }

  describe 'PUT #update' do
    def put_update
      put :update, id: invitation, invitation: invitation_params
    end

    it 'does not create a new invitation' do
      expect { put_update }.not_to change(Invitation, :count)
    end

    it 'updates invitation with the correct params' do
      put_update
      invitation.reload
      expect(invitation.rsvp).to eq(true)
    end
  end
end
