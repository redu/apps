# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_environment_association do
    user { FactoryGirl.create(:user) }
    environment { FactoryGirl.create(:environment) }
  end
end
