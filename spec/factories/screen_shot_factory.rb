# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screen_shot do
    app { FactoryGirl.create(:app) }
    screen { open("app/assets/images/screen.png") }
  end
end
