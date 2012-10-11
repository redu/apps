# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_course_association do
    user { FactoryGirl.create(:user) }
    course { FactoryGirl.create(:course) }
  end
end
