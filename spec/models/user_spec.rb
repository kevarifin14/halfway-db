require 'active_record_helper'
require './app/models/user'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:friends).class_name('User') }
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:invitations) }
    it { is_expected.to have_many(:groups).through(:memberships) }
    it { is_expected.to have_many(:events).through(:invitations) }
  end

  describe 'columns' do
    it do
      is_expected.to have_db_column(:email).of_type(:string)
        .with_options(
          default: '',
          null: false,
        )
    end

    it { is_expected.to have_db_column(:latitude).of_type(:decimal) }
    it { is_expected.to have_db_column(:longitude).of_type(:decimal) }

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
