require './app/serializers/V1/sessions_serializer'

module V1
  # Verification for phone numbers
  class PhoneNumbersController < ApplicationController
    def verify
      @phone_number =
        PhoneNumber.find_by(phone_number: params.fetch(:hidden_phone_number))
      @phone_number.verify(params.fetch(:pin))
      render json: @user, serializer: V1::SessionsSerializer, root: nil
    end
  end
end
