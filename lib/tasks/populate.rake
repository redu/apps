# encoding: utf-8

desc "Populate DB with random_data and Faker stuff"
task :random_population, :n do |t, args|
  cats = Array.new
  lvls = Array.new
  lvls << Category.create(name: "Ensino Infantil", kind: "Nível")
  lvls << Category.create(name: "Ensino Fundamental", kind: "Nível")
  lvls << Category.create(name: "Ensino Médio", kind: "Nível")
  lvls << Category.create(name: "Ensino Superior", kind: "Nível")
  lvls << Category.create(name: "Educação Profissional", kind: "Nível")
  cats << Category.create(name: "Matemática", kind: "Subárea")
  cats << Category.create(name: "Português", kind: "Subárea")
  cats << Category.create(name: "Biologia", kind: "Subárea")
  cats << Category.create(name: "Geografia", kind: "Subárea")
  cats << Category.create(name: "História", kind: "Subárea")
  cats << Category.create(name: "Ciências Exatas e da Natureza", kind: "Área")
  cats << Category.create(name: "Ciências Humanas", kind: "Área")
  cats << Category.create(name: "Saúde", kind: "Área")
  languages = ['Português', 'Inglês', 'Espanhol', 'Italiano', 'Japonês',
               'Francês', 'Russo', 'Alemão', 'Aramaico', 'Esperanto', 'Dothraki']

  args[:n].to_i.times do
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
    lvls[rand(lvls.length)].apps << app # Associa o App a um Nível de Ensino
    cats[rand(cats.length)].apps << app # Associa o App a uma Área de Ensino
  end
end

namespace :populate do
  # Chamada: 'rake populate:arbitrary[n]', com n um número inteiro não negativo
  desc "Populate DB with an arbitrary quantity of entities"
  task :arbitrary, [:n] => [:environment] do |t, args|
    task(:random_population).invoke(args[:n])
  end

  desc "Populate DB with one only entity"
  task one: :environment do
    task(:random_population).invoke(1)
  end

  desc "Populate DB with one hundred entities"
  task a_few: :environment do
    task(:random_population).invoke(100)
  end

  desc "Populate DB with one thousand entities"
  task some: :environment do
    task(:random_population).invoke(1000)
  end

  desc "Populate DB with ten thousand entities"
  task a_lot: :environment do
    task(:random_population).invoke(10000)
  end

  desc "Create Redu hierarchy for first user (user id 1)"
  task hierarchy: :environment do
    user = User.first || FactoryGirl.create(:user)
    environment = Environment.create(name: "AVA Redu", eid: 123, owner: user)
    environment.users << user
    course = Course.create(name: "Primeiros Passos", cid: 123, owner: user,
                           environment: environment)
    space = Space.create(name: "Aprendendo a Usar o Redu", sid: 123)
    course.spaces << space
    subject1 = Subject.create(name: "Redu para Professores", suid: 123,
                              space: space)
    subject2 = Subject.create(name: "Redu para Alunos", suid: 1234,
                              space: space)
    subject3 = Subject.create(name: "Redu para Gestores", suid: 12345,
                              space: space)

  end
end
