require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:friends).class_name('User') }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(
          default: '',
          null: false,
        )
    end

    it do
      is_expected.to have_db_column(:username).of_type(:string)
        .with_options(
          default: '',
          null: false,
        )
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
  end
end
