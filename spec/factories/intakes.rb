# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :intake do
    course {FactoryGirl.build(:course)}
    start "2016-05-23 10:31:28"
    finish "2016-05-24 10:31:28"
    location "Coder Factory"
    class_size "20"
  end
end
