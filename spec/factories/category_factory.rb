FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    kind "Nivel"
  end
end
