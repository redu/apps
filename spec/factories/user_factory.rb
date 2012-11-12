FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| n }
    sequence(:login) { |n| "user#{n}" }
    last_name 'da Silva'
    first_name 'Joao'
    role :member
    thumbnail { open('app/assets/images/user_thumb.png') }
    sequence(:email) { |n| "user#{n}@email.com" }
    password "password"
    password_confirmation "password"

    factory :member do
      role :member
    end

    factory :specialist do
      role :specialist
    end
  end
end
