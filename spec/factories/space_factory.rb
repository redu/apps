# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :space do
    sequence(:core_id)
    name "Nova Disciplina"

    factory :complete_space do
      after(:create) do |space|
        space.subjects << FactoryGirl.create(:complete_subject)
      end
    end
  end
end
