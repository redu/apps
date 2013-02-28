FactoryGirl.define do
  factory :answer do
    kind nil
    author { FactoryGirl.create(:member) }
    app { FactoryGirl.create(:app) }
    body "Gostei. Parabens pelo aplicativo!"
    in_response_to { FactoryGirl.create(:comment) }
  end
end
