# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    intake {FactoryGirl.build(:intake)}
    people_attending "2"
    total_cost "0.00"
  end
end
