FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| n }
    sequence(:login) { |n| "user#{n}" }
    last_name 'da Silva'
    first_name 'Joao'
    role :member

    factory :member do
      role :member
    end

    factory :specialist do
      role :specialist
    end
  end
end