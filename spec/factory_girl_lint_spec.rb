require 'rails_helper'

RSpec.describe 'FactoryGirl linting' do
  it('ensures factories use good syntax') { FactoryGirl.lint }
end
