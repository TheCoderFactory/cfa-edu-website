# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    course_type "Short Course"
    name "Coding Kickstarter"
    description "Learn coding."
    tagline "Free coding."
    slug "coding-kickstarter"
    price "0.00"

    factory :invalid_course do
      course_type nil
    end
  end
end
