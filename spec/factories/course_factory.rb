# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    sequence(:core_id)
    name "Novo Curso"
    owner { FactoryGirl.create(:user) }
    environment { FactoryGirl.create(:environment) }
  end
end
