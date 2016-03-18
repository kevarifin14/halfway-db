module V1
  # CRUD for friends
  class FriendsController < ApplicationController
    def create
      @friends = friends
      render json: @friends, root: 'friends'
    end

    private

    def friends
      friends_list = []
      User.all.each do |user|
        if user.id != current_user.id
          contacts.each do |contact|
            contact.fetch('phoneNumbers').each do |phoneNumber|
              if phoneNumber.fetch('value').phony_normalized == user.phone_number
                friends_list << attributes(user, contact)
                break
              end
            end
          end
        end
      end
      friends_list
    end

    def attributes(user, contact)
      user.attributes.select do |key, _|
        user_attributes_to_include.include?(key)
      end.merge('name' => name(contact))
    end

    def name(contact)
      contact.fetch('name').fetch('formatted')
    end

    def user_attributes_to_include
      ['id', 'phone_number', 'verified', 'access_token', 'latitude', 'longitude']
    end

    def contacts
      params.require(:contacts)
    end

    def current_user
      @current_user ||= User.find(params.require(:user_id))
    end
  end
end
