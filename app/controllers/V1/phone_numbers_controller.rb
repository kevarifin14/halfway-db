require './app/serializers/V1/sessions_serializer'

module V1
  # Verification for phone numbers
  class PhoneNumbersController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def verify
      @phone_number =
        PhoneNumber.find_by(phone_number: params.require(:hidden_phone_number))
      @phone_number.verify(params.require(:pin_number))
      render json: @user, serializer: V1::SessionsSerializer, root: nil
    end
  end
end
