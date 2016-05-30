# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :promo_code do
    code "test_code"
    percent 10
    note "Testing code"

    factory :invalid_promo_code do
      code nil
    end
  end
end
