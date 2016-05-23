# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    booking {FactoryGirl.build(:booking)}
    amount "0.00"
  end
end
