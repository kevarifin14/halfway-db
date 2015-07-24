require 'rails_helper'

RSpec.describe V1::GroupsController do
  let(:user) { create(User) }
  let(:group) { create(Group, name: name) }
  let(:name) { 'group' }
  let(:group_member) { create(User) }
  let(:another_group_member) { create(User) }

  shared_examples 'a successful action' do
    specify {  expect(response).to be_successful }
  end

  describe 'GET #index' do
    before do
      group.users.append(user)
      get :index, user_id: user
    end

    it_behaves_like 'a successful action'

    it 'lists groups of the specific user' do
      expect(user.groups).to eq([group])
    end
  end

  describe 'POST #create' do
    def post_create
      post :create,
           user_id: user,
           name: 'group',
           users: [group_member, another_group_member]
    end

    it_behaves_like 'a successful action'

    it 'creates a new group' do
      expect { post_create }.to change(Group, :count).by(1)
    end

    it 'has the user in the group' do
      post_create
      expect(Group.last.users).to include(user)
    end

    it 'adds the specified users to the group' do
      post_create
      expect(Group.last.users)
        .to include(user, group_member, another_group_member)
    end

    it 'renders json showing the group' do
      post_create
      body = JSON.parse(response.body)

      expect(body).to include('name' => name)
    end
  end
end
