require 'rails_helper'

RSpec.describe V1::FriendsController do
  let(:contacts) do
    [
      {
        'id' => 1,
        'rawId' => nil,
        'displayName' => nil,
        'name' => 'Kate Bell',
        'nickname' => nil,
        'phoneNumbers' => [
          {
            'value' => '(555) 564-8583',
            'pref' => false,
            'id' => 0,
            'type' => 'mobile',
          },
          {
            'value' => '(415) 555-3695',
            'pref' => false,
            'id' => 1,
            'type' => '_$!<Main>!$_',
          },
        ],
      },
      {
        'id' => 2,
        'rawId' => nil,
        'displayName' => nil,
        'name' => 'Daniel Higgins Jr.',
        'nickname' => nil,
        'phoneNumbers' => [
          {
            'value' => '555-478-7672',
            'pref' => false,
            'id' => 0,
            'type' => 'home',
          },
          {
            'value' => '(408) 555-5270',
            'pref' => false,
            'id' => 1,
            'type' => 'mobile',
          },
          {
            'value' => '(408) 555-3514',
            'pref' => false,
            'id' => 2,
            'type' => 'fax',
          },
        ],
      },
    ]
  end

  let(:friends_json) do
    {
      'friends' => [
        {
          'id' => User.first.id,
          'phone_number' => '4085555270',
          'verified' => false,
          'access_token' => User.first.access_token,
          'latitude' => '15.0',
          'longitude' => '15.5',
          'name' => 'Daniel Higgins Jr.',
        },
      ],
    }
  end

  let(:user) { create(User) }
  let!(:user_1) { create(User, phone_number: '4085555270') }
  let!(:user_2) { create(User) }
  let!(:user_3) { create(User) }

  before do
    request.env['HTTP_AUTHORIZATION'] = user.access_token
  end

  describe 'POST #create' do
    before do
      post :create, user_id: user, contacts: contacts
    end

    it 'returns json hash of all users that match phone numbers' do
      expect(JSON.parse(response.body)).to eq(friends_json)
    end
  end
end
