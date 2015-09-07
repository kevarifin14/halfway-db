require 'rails_helper'
require 'halfway_calculator'

RSpec.describe HalfwayCalculator do
  let(:event) { create(Event, event_params) }
  let(:event_params) { attributes_for(Event).merge(users) }
  let(:users) { { users: [first_user, second_user] } }
  let(:first_user) { create(User, latitude: 15, longitude: 15) }
  let(:second_user) { create(User, latitude: 45, longitude: 45) }

  it 'calculates the correct halfway location' do
    expect(described_class.call(event: event)).to eq(
      latitude: 30.0,
      longitude: 30.0,
    )
  end
end
