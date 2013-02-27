FactoryGirl.define do
  factory :comment do
    author { FactoryGirl.create(:member) }
    app { FactoryGirl.create(:app) }
    body "Gostei. Parabens pelo aplicativo!"

    factory :specialized_comment do
      kind :specialized
      body "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "    + \
        "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim "    + \
        "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "     + \
        "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit" + \
        " in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "       + \
        "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui "      + \
        "officia deserunt mollit anim id est laborum."
    end

    factory :common_comment do
      kind :common #default
      body "Ae, mano! Muito massa esse app, vei."

      after(:create) do |comment|
        comment.answers << FactoryGirl.create(:comment, body: "Eh mesmo!",
                                              kind: :answer,
                                              app: comment.app)
      end
    end
  end
end
