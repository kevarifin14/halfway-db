require 'rails_helper'

RSpec.describe V1::EventsController do
  let(:user) { create(User) }
  let(:event) { create(Event, description: description, date: date) }
  let(:invited_user) { create(User) }
  let(:another_invited_user) { create(User) }
  let(:description) { 'event' }
  let(:date) { '2015-06-06'.to_date }

  shared_examples 'a successful action' do
    specify {  expect(response).to be_successful }
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
      expect(body[0]).to include('date' => date.to_s)
    end
  end

  describe 'POST #create' do
    def post_create
      post :create,
           user_id: user,
           date: date,
           description: description,
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

    it 'sets the location as the midpoint of all users that have rsvped' do
      post_create
      expect(Event.last.latitude).to eq(user.latitude)
      expect(Event.last.longitude).to eq(user.longitude)
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
      expect(body).to include('date' => date.to_s)
    end
  end
end
