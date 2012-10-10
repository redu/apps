echo 'Dropping...'
bundle exec rake db:drop:all
echo 'Creating...'
bundle exec rake db:create:all
echo 'Migrating...'
bundle exec rake db:migrate
echo 'Preparing...'
bundle exec rake db:test:prepare
echo 'Finished!'
