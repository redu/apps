namespace :db do
  desc "Invoke all rake tasks related to database setup"
  task prepare: :environment do
    puts 'Dropping...'
    Rake::Task["db:drop:all"].execute
    puts 'Creating...'
    Rake::Task["db:create:all"].execute
    puts 'Migrating...'
    Rake::Task["db:migrate"].reenable # reativa
    Rake::Task["db:migrate"].invoke   # executa com dependências
    Rake::Task["db:migrate"].execute  # obriga a execução
    puts 'Preparing...'
    Rake::Task["db:test:prepare"].invoke
    puts 'Finished!'
  end
end
