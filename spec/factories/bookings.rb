# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    association :intake
    people_attending "2"
    total_cost "0.00"

    factory :invalid_booking do
      people_attending nil
    end
  end
end
