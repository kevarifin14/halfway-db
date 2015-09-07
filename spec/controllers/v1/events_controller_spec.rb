require 'rails_helper'

RSpec.describe V1::EventsController do
  let(:user) { create(User) }
  let(:event) { create(Event, description: description, date: date) }
  let(:invited_user) { create(User) }
  let(:another_invited_user) { create(User) }
  let(:description) { 'event' }
  let(:date) { '2015-06-06'.to_datetime }
  let(:search_param) { 'restaurant' }

  let(:meeting_point_data) do
    { meeting_point: meeting_point, address: address }
  end
  let(:address) { '1234 Telegraph Ave.' }
  let(:meeting_point) { 'Katsumi' }

  before do
    allow(HalfwayLocationRetriever).to receive(:call)
      .and_return(meeting_point_data)
  end

  shared_examples 'a successful action' do
    specify { expect(response).to be_successful }
  end

  describe 'GET #index' do
    before do
      event.users.append(user)
      get :index, user_id: user
    end

    it_behaves_like 'a successful action'

    it 'renders json showing the users events' do
      body = JSON.parse(response.body)
      expect(body[0]).to include('description' => description)
    end
  end

  describe 'POST #create' do
    def post_create
      post :create,
           user_id: user,
           date: date,
           description: description,
           search_param: search_param,
           users: [invited_user, another_invited_user]
    end

    it_behaves_like 'a successful action'

    it 'creates an event' do
      expect { post_create }.to change(Event, :count).by(1)
    end

    it 'adds the user to the event and sets their rsvp as true' do
      post_create
      expect(Event.last.users).to include(user)
      expect(Invitation.find_by(user: user, event: Event.last).rsvp).to eq(true)
    end

    it 'updates location data based on all users that have rsvped' do
      post_create
      expect(Event.last.address).to eq(address)
      expect(Event.last.meeting_point).to eq(meeting_point)
    end

    it 'includes the specified users invited to event' do
      post_create
      expect(Event.last.users)
        .to include(user, invited_user, another_invited_user)
    end

    it 'renders json showing the event' do
      post_create
      body = JSON.parse(response.body)

      expect(body).to include('description' => description)
    end
  end

  describe 'DELETE #destroy' do
    def delete_destroy
      delete :destroy, id: event
    end

    let!(:event) { create(Event) }

    it 'destroys the event' do
      expect { delete_destroy }.to change(Event, :count).by(-1)
    end
  end
end
