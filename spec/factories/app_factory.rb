FactoryGirl.define do
  factory :app do
    sequence(:name) { |n| "Recurso Educacional Aberto #{n}" }
    author "Redu Educational Technologies"
    language "Portugues (pt_BR)"
  end
end
