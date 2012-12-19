# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    sequence(:core_id)
    name "Novo Modulo"
    finalized true

    factory :complete_subject do
      after(:create) do |subject|
        subject.lectures << FactoryGirl.create(:lecture)
      end
    end
  end
end
