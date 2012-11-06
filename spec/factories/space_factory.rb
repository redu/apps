# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :space do
    sequence(:sid)
    name "Nova Disciplina"
    course { FactoryGirl.create(:course) }
  end
end
