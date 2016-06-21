# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    association :booking
    amount "0.00"
    paid true
  end
end
