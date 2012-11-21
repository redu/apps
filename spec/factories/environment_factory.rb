# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :environment do
    sequence(:core_id)
    name "Ambiente Virtual de Aprendizagem"
    owner { FactoryGirl.create(:user) }
  end
end
