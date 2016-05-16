require 'rails_helper'
require 'halfway_location_retriever'

RSpec.describe HalfwayLocationRetriever do
  let(:event) { create(Event, event_params) }
  let(:event_params) { attributes_for(Event).merge(users) }
  let(:users) { { users: [first_user, second_user] } }
  let(:first_user) { create(User, latitude: 15, longitude: 15) }
  let(:second_user) { create(User, latitude: 45, longitude: 45) }
  let(:search_param) { 'restaurant' }
  let(:halfway_calculation) do
    { latitude: 37.866579, longitude: -122.255807 }
  end
  let(:meeting_point_data) do
    {
      meeting_point: meeting_point,
      address: address,
      latitude: 37.863683,
      longitude: -122.258976,
      image: 'https://s3-media2.fl.yelpcdn.com' \
        '/bphoto/qJ7vw6e9_ScvEbnfFxvEfQ/ms.jpg',
    }
  end
  let(:address) { '1234 Telegraph Ave.' }
  let(:meeting_point) { 'Katsumi' }

  before do
    allow(HalfwayCalculator).to receive(:call)
      .with(event: event).and_return(halfway_calculation)
    allow(HalfwayLocationRetriever).to receive(:call)
      .and_return(meeting_point_data)
  end

  it 'gets the correct location' do
    expect(described_class.call(event: event, search_param: search_param))
      .to eq(
        meeting_point: meeting_point,
        address: address,
        latitude: 37.863683,
        longitude: -122.258976,
        image: 'https://s3-media2.fl.yelpcdn.com' \
          '/bphoto/qJ7vw6e9_ScvEbnfFxvEfQ/ms.jpg',
      )
  end
end
