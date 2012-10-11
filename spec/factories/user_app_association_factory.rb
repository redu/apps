# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_app_association do
    user { FactoryGirl.create(:user) }
    app { FactoryGirl.create(:app) }
  end
end
