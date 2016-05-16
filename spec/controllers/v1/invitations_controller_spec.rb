require 'rails_helper'

RSpec.describe V1::InvitationsController do
  let!(:user) { create(User, latitude: 20, longitude: 20) }
  let!(:creator) { create(User, latitude: 10, longitude: 10) }
  let(:event) { create(Event) }
  let!(:user_invitation) do
    create(Invitation, user: user, event: event)
  end
  let!(:creator_invitation) do
    create(Invitation, user: creator, event: event, rsvp: true)
  end
  let(:invitation_params) { attributes_for(Invitation).merge(rsvp: true) }
  let(:meeting_point_data) do
    { meeting_point: meeting_point, address: address }
  end
  let(:address) { '1234 Telegraph Ave.' }
  let(:meeting_point) { 'Katsumi' }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token

    allow(HalfwayLocationRetriever).to receive(:call)
      .and_return(meeting_point_data)
  end

  describe 'GET #index' do
    def req_index
      get :index, event_id: event
    end

    before { req_index }

    specify { expect(response).to be_successful }

    it 'renders the correct invitations' do
      expect(JSON.parse(response.body)).to match_array(
        'invitations' =>
          [
            {
              'id' => user_invitation.id,
              'event_id' => user_invitation.event_id,
              'user_id' => user_invitation.user_id,
              'created_at' =>
                JSON.parse(response.body).fetch('invitations')
                  .first.fetch('created_at'),
              'updated_at' =>
                JSON.parse(response.body).fetch('invitations')
                  .first.fetch('updated_at'),
              'rsvp' => nil,
            },
            {
              'id' => creator_invitation.id,
              'event_id' => creator_invitation.event_id,
              'user_id' => creator_invitation.user_id,
              'created_at' =>
                JSON.parse(response.body).fetch('invitations')
                  .second.fetch('created_at'),
              'updated_at' =>
                JSON.parse(response.body).fetch('invitations')
                  .second.fetch('updated_at'),
              'rsvp' => true,
            },
          ],
      )
    end
  end

  describe 'GET #show' do
    let(:invitation) { user_invitation }
    before { get :show, id: user_invitation.id }
    it 'is a successful action' do
      expect(response).to be_successful
    end

    it 'gets the correct invitation' do
      invitation = JSON.parse(response.body).fetch('invitation')
      expect(invitation.fetch('id')).to eq(user_invitation.id)
    end
  end

  describe 'PUT #update' do
    let(:invitation) { user_invitation }
    def put_update(invitation)
      put :update, id: invitation, invitation: invitation_params
    end

    it 'does not create a new invitation' do
      expect { put_update(invitation) }.not_to change(Invitation, :count)
    end

    it 'updates invitation with the correct params' do
      put_update(invitation)
      invitation.reload
      expect(invitation.rsvp).to eq(true)
    end

    context 'all users have rsvped' do
      it 'updates event location if all users have rsvped' do
        put_update(invitation)
        event.reload
        expect(event.meeting_point).to eq(meeting_point)
        expect(event.address).to eq(address)
      end
    end

    context 'some users have not rsvped' do
      let(:invitation) { creator_invitation }

      it 'does not update event location if all users have not rsvped' do
        put_update(invitation)
        event.reload
        expect(event.meeting_point).to eq(nil)
        expect(event.address).to eq(nil)
      end
    end

    context 'all users rsvp false' do
      let(:invitation) { creator_invitation }
      let(:invitation_params) { attributes_for(Invitation).merge(rsvp: false) }

      it 'does not update the location' do
        put_update(invitation)
        put_update(user_invitation)
        event.reload
        expect(event.meeting_point).to eq(nil)
        expect(event.address).to eq(nil)
      end
    end
  end
end
