# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :intake do
    association :course
    start "2016-05-23 10:31:28"
    finish "2016-05-24 10:31:28"
    location "Coder Factory"
    days "Mondays"

    factory :invalid_intake do
      start nil
    end
  end
end
