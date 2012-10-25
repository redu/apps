# encoding: utf-8

desc "Populate DB with random_data and Faker stuff"
task :random_population, :n do |t, args|
  cats = Array.new
  cats << Category.create(name: "Ensino Básico", kind: "Nível")
  cats << Category.create(name: "Ensino Médio", kind: "Nível")
  cats << Category.create(name: "Ensino Superior", kind: "Nível")
  cats << Category.create(name: "Ensino Técnico", kind: "Nível")
  cats << Category.create(name: "Matemática", kind: "Área")
  cats << Category.create(name: "Português", kind: "Área")
  cats << Category.create(name: "Ciências Exatas e da Natureza", kind: "Área")
  languages = ['Português', 'Inglês', 'Espanhol', 'Italiano', 'Japonês',
               'Francês', 'Russo', 'Alemão', 'Aramaico']

  args[:n].times do
    app = FactoryGirl.create(:complete_app, name: Faker::Company.catch_phrase,
                             author: Faker::Company.name,
                             language: languages[rand(languages.length)],
                             objective: Random.paragraphs,
                             synopsis: Random.paragraphs(3),
                             country: Random.country,
                             publishers: Faker::Company.name,
                             submitters: Faker::Company.name,
                             url: Faker::Internet.domain_name,
                             copyright: Faker::Company.name)
    cats[rand(cats.length)].apps << app
  end
end

namespace :populate do
  task one: :environment do
    task(:random_population).invoke(1)
  end

  task a_few: :environment do
    task(:random_population).invoke(100)
  end

  task some: :environment do
    task(:random_population).invoke(1000)
  end

  task a_lot: :environment do
    task(:random_population).invoke(10000)
  end
end
