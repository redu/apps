# encoding: utf-8

namespace :bootstrap do

  desc "Create apps with random categories"
  task create_apps: :environment do
    categories = (0..3).collect {|i| Category.create(name: "Cat #{i}",
      kind: "Área")}
    categories << (0..2).collect { |i| Category.create(name: "Cat #{i}",
      kind: "Nível")}
    100.times do
      app = FactoryGirl.create(:app)
      app.categories << categories.sample(rand(4))
    end
  end

  desc "Create users"
  task create_users: :environment do
    10.times do
       FactoryGirl.create(:user)
    end
  end

  desc "Insert apps with random categories"
  task create_apps: :environment do
    categories = (0..5).collect {|i| Category.create(name: "Cat #{i}",
                                                     kind: "Nível") }
    100.times do
      app = FactoryGirl.create(:app)
      app.categories << categories.sample(rand(3))
    end
  end

  desc "Create users"
  task create_users: :environment do
    10.times do
      FactoryGirl.create(:user)
    end
  end

  desc "Create stuff"
  task create_stuff: :environment do
    env = Environment.create(name: "Ambiente",
                             core_id: 2) {|e| e.owner = FactoryGirl.create(:user)}

    course = Course.create(name: "cc", core_id: 9) do |c|
      c.owner = FactoryGirl.create(:user)
      c.environment = env
    end
    env.courses << course
    space = Space.create(name: "coisado",
                         core_id: 231) {|s| s.course = course }

    subject = Subject.create(name: "ciencias",
                             core_id: 75) {|s| s.space = space }
  end

  desc "Run all"
  task all: [:create_apps, :create_users]
end
