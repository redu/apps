# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    sequence(:core_id)
    name "Novo Modulo"
    space { FactoryGirl.create(:space) }
  end
end
