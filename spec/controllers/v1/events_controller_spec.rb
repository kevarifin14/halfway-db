require 'rails_helper'

RSpec.describe V1::EventsController do
  let(:user) { create(User) }
  let(:event1) { create(Event, description: description, date: date) }
  let(:event2) { create(Event, description: description, date: date) }
  let(:invited_user) { create(User) }
  let(:another_invited_user) { create(User) }
  let(:description) { 'Event' }
  let(:date) { '2015-06-06'.to_datetime }
  let(:search_param) { 'restaurant' }

  let(:meeting_point_data) do
    {
      meeting_point: meeting_point,
      address: address,
      latitude: 100.0,
      longitude: 100.0,
      image: 'img_file.jpg',
    }
  end
  let(:address) { '1234 Telegraph Ave.' }
  let(:meeting_point) { 'Katsumi' }

  let(:valid_event_attributes) { attributes_for(Event) }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token
    allow(HalfwayLocationRetriever).to receive(:call)
      .and_return(meeting_point_data)
  end

  shared_examples 'a successful action' do
    specify { expect(response).to be_successful }
  end

  describe 'GET #index' do
    before do
      event1.users.append(user)
      event2.users.append(user)
      get :index,
          user_id: user
    end

    it_behaves_like 'a successful action'

    it 'renders json showing the users events' do
      expect(JSON.parse(response.body)).to eq(
        'events' => [
          {
            'id' => event1.id,
            'date' => '2015-06-06T00:00:00.000Z',
            'description' => 'Event',
            'meeting_point' => nil,
            'address' => nil,
            'search_param' => 'restaurant',
            'friends' => [
              {
                'id' => user.id,
                'phone_number' => user.phone_number,
                'verified' => false,
                'access_token' => user.access_token,
                'latitude' => '15.0',
                'longitude' => '15.5',
              },
            ],
            'latitude' => nil,
            'longitude' => nil,
            'image' => nil,
          },
          {
            'id' => event2.id,
            'description' => 'Event',
            'date' => '2015-06-06T00:00:00.000Z',
            'meeting_point' => nil,
            'address' => nil,
            'search_param' => 'restaurant',
            'friends' => [
              {
                'id' => user.id,
                'phone_number' => user.phone_number,
                'verified' => false,
                'access_token' => user.access_token,
                'latitude' => '15.0',
                'longitude' => '15.5',
              },
            ],
            'latitude' => nil,
            'longitude' => nil,
            'image' => nil,
          },
        ],
      )
    end
  end

  describe 'GET #show' do
    before do
      get :show, id: event1
    end

    it_behaves_like 'a successful action'

    it 'renders json of the requested event' do
      expect(JSON.parse(response.body)).to match_array(
        [
          [
            'event',
            {
              'id' => event1.id,
              'date' => '2015-06-06T00:00:00.000Z',
              'description' => 'Event',
              'meeting_point' => nil,
              'address' => nil,
              'search_param' => 'restaurant',
              'friends' => [],
              'latitude' => nil,
              'longitude' => nil,
              'image' => nil,
            },
          ],
        ],
      )
    end
  end

  describe 'POST #create' do
    def post_create(users)
      post :create,
           user_id: user,
           event: valid_event_attributes,
           users: users
    end

    it_behaves_like 'a successful action'

    it 'creates an event' do
      expect { post_create([]) }.to change(Event, :count).by(1)
    end

    it 'adds the user to the event and sets their rsvp as true' do
      post_create([invited_user, another_invited_user])
      expect(Event.last.users).to include(user)
      expect(Invitation.find_by(user: user, event: Event.last).rsvp).to eq(true)
    end

    it 'updates location data based on all users that have rsvped' do
      post_create([])
      expect(Event.last.address).to eq(address)
      expect(Event.last.meeting_point).to eq(meeting_point)
    end

    it 'does not update location data if all users have not rsvped' do
      post_create([invited_user, another_invited_user])
      expect(Event.last.address).to eq(nil)
      expect(Event.last.meeting_point).to eq(nil)
    end

    it 'includes the specified users invited to event' do
      post_create([invited_user, another_invited_user])
      expect(Event.last.users)
        .to match_array([user, invited_user, another_invited_user])
    end

    it 'renders json showing the event' do
      post_create([invited_user, another_invited_user])
      body = JSON.parse(response.body)

      expect(body.fetch('event')).to include('description' => description)
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
