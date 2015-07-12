module V1
  class GroupsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def index
      render json: user.groups
    end

    def create
      @group = Group.create(group_params)
      @group.users << user
      @group.users << group_members
      puts @group.users
      render json: @group
    end

    private

    def user
      User.find(params.require(:user_id))
    end

    def group_params
      params.permit(:name)
    end

    def group_members
      group_members = []
      params.fetch(:users).each do |user|
        group_members.append(User.find(user))
      end
      group_members
    end
  end
end
