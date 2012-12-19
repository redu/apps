# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:core_id)
    name "Novo Curso"
    owner { FactoryGirl.create(:user) }

    factory :complete_course do
      after(:create) do |course|
        course.spaces << FactoryGirl.create(:complete_space)
      end
    end
  end
end
