require 'rails_helper'
require 'halfway_calculator'

RSpec.describe HalfwayCalculator do
  let(:event) { create(Event, event_params) }
  let(:event_params) { attributes_for(Event).merge(invitations) }
  let(:invitation_1) { create(Invitation, rsvp: true, user: first_user) }
  let(:invitation_2) { create(Invitation, rsvp: true, user: second_user) }
  let(:invitation_3) { create(Invitation, rsvp: false, user: third_user) }
  let(:users) { { users: [first_user, second_user, third_user] } }
  let(:invitations) do
    { invitations: [invitation_1, invitation_2, invitation_3] }
  end
  let(:first_user) do
    create(
      User,
      latitude: 15,
      longitude: 15,
    )
  end
  let(:second_user) do
    create(
      User,
      latitude: 45,
      longitude: 45,
    )
  end
  let(:third_user) do
    create(
      User,
      latitude: 13,
      longitude: 32,
    )
  end

  it 'calculates the correct halfway location' do
    expect(described_class.call(event: event)).to eq(
      latitude: 30.0,
      longitude: 30.0,
    )
  end
end
