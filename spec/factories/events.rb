FactoryGirl.define do
  factory :event do
    description 'Event'
    date '1996-01-03'.to_datetime
    search_param 'restaurant'
  end
end
