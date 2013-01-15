FactoryGirl.define do
  factory :answer do
    author { FactoryGirl.create(:member) }
    app { FactoryGirl.create(:app) }
    body "Gostei. Parabens pelo aplicativo!"
    type :answer
    in_response_to { FactoryGirl.create(:comment) }
  end
end
