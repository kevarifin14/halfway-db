require 'rails_helper'

RSpec.describe V1::GroupsController do
  let(:user) { create(User) }
  let(:group) { create(Group) }
  let(:group_member) { create(User) }
  let(:another_group_member) { create(User) }

  describe 'GET #index' do
    before { group.users.append(user) }
    it 'lists groups of the specific user' do
      expect(user.groups).to eq([group])
    end
  end

  describe 'POST #create' do
    def post_create
      post :create, user_id: user, name: 'group', users:[group_member, another_group_member]
    end

    it 'creates a new group' do
      expect{ post_create }.to change(Group, :count).by(1)
    end

    it 'has the user in the group' do
      post_create
      expect(Group.last.users).to include(user)
    end
  end
end
