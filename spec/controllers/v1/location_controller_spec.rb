require 'rails_helper'

RSpec.describe V1::LocationController do
  let(:user) { create(User) }

  let(:location_params) do
    attributes_for(Location).merge(latitude: latitude, longitude: longitude)
  end
  let(:latitude) { 20.123 }
  let(:longitude) { -14.123 }


  shared_examples 'a successful action' do
    specify {  expect(response).to be_successful }
  end


  describe 'POST #create' do
    let(:created_location) { Location.last }

    it_behaves_like 'a successful action'

    def post_create
      post :create, user_id: user, location: location_params
    end

    it 'creates a new location' do
      expect{ post_create }.to change(Location, :count).by(1)
    end

    it 'creates a new location assigned to specified user' do
      post_create
      expect(created_location.user).to eq(user)
    end

    it 'creates a new location with the correct latitude and longitude' do
      post_create
      expect(created_location.latitude).to eq(latitude)
      expect(created_location.longitude).to eq(longitude)
    end

    it 'renders json of the created location' do
      post_create
      body = JSON.parse(response.body)

      expect(body).to include('latitude' => latitude)
      expect(body).to include('longitude' => longitude)
      expect(body).to include('user_id' => user.id)
    end
  end

  describe 'PUT #update' do
    let(:updated_location) { Location.find(location) }
    let!(:location) { user.create_location(location_params) }
    let(:new_latitude) { 15 }
    let(:updated_attributes) { location_params.merge(latitude: new_latitude) }

    it_behaves_like 'a successful action'

    def put_update
      put :update, id: location, location: updated_attributes
    end

    it 'does not create a new location' do
      expect{ put_update }.not_to change(Location, :count)
    end

    it 'updates the location attributes' do
      put_update
      expect(updated_location.latitude).to eq(new_latitude)
    end

    it 'renders json of the created location' do
      put_update
      body = JSON.parse(response.body)

      expect(body).to include('latitude' => new_latitude)
      expect(body).to include('longitude' => longitude)
      expect(body).to include('user_id' => user.id)
    end

  end
end
