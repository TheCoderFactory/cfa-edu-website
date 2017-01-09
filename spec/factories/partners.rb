# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :partner do
    url "MyString"
    name "MyString"
    image "MyString"
    order 1
    active false
  end
end
