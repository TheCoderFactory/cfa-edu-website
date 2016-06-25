# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    association :intake
    people_attending "2"
    total_cost "0.00"
    firstname "Pete"
    lastname "Argent"
    email "test@test.com"
    phone "1111111111"
    age "33"
    city "Sydney"
    country "AU"

    factory :invalid_booking do
      people_attending nil
    end
  end
end
