require 'rails_helper'

RSpec.describe V1::InvitationsController do
  let!(:user) { create(User, latitude: 20, longitude: 20) }
  let!(:creator) { create(User, latitude: 10, longitude: 10) }
  let(:event) { create(Event) }
  let!(:user_invitation) { create(Invitation, user: user, event: event) }
  let!(:creator_invitation) do
    create(Invitation, user: creator, event: event, rsvp: true)
  end
  let(:invitation_params) { attributes_for(Invitation).merge(rsvp: true) }

  describe 'PUT #update' do
    def put_update
      put :update, id: user_invitation, invitation: invitation_params
    end

    it 'does not create a new invitation' do
      expect { put_update }.not_to change(Invitation, :count)
    end

    it 'updates invitation with the correct params' do
      put_update
      user_invitation.reload
      expect(user_invitation.rsvp).to eq(true)
    end

    it 'updates the event meeting location based on the new user location' do
      put_update
      event.reload
      expect(event.latitude).to eq(15.0)
      expect(event.longitude).to eq(15.0)
    end
  end
end
