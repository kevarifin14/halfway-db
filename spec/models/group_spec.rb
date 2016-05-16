# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'active_record_helper'
require './app/models/group'

RSpec.describe Group do
  describe 'columns' do
    it { is_expected.to have_db_column(:name).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users).through(:memberships) }
    it { is_expected.to have_many(:memberships) }
  end
end
