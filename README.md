# Redu Apps

This is the Redu Applications Portal project, which offers Educational Resources
for online courses in [Redu](http://redu.com.br).

## Setup

### Paperclip
Run
```shell
rake paperclip:refresh:missing_styles
```
if you need it.

### Sunspot / Solr
Once Solr server is properly installed you may run it. If you're using
[Sunspot Solr Gem](https://github.com/outoftime/sunspot/tree/master/sunspot_solr#sunspotsolr)
it can be easily done with the following rake task:
```shell
rake sunspot:solr:start # or sunspot:solr:run if you want it on foreground
```
What about if you already have data in your database? Run reindex!
```shell
rake sunspot:reindex
```

### Database population
Well, Sunspot / Solr is a nice search service but what is it reason to be if we do not have the such content in which perform our seeking? You can invoke the following rake tasks in order to populate your database with fake data:
```shell
rake populate:one # creates 1 app
rake populate:a_few # creates 100 apps
rake populate:some # creates 1000 apps
rake populate:a_lot # creates 10000 apps
rake populate:arbitrary[n] # creates n apps
```
Do not forget running Solr server before creating apps or you'll get into some trouble.

You may later want to create Redu components hierarchy (Environment, Course, Space and Subjects):
```shell
rake populate:hierarchy # creates Environment, Course, Space, Subjects and links them with first (or a brand new) user
```

## Untied consumer

As you probably know, this application relies on entities created by another service (aka core) propagated via message bus. In development mode you can start the consumer with the following rake task:

```sh
$ bundle exec rake untied:consumer:work
```

In order to run the message bus consumer as a daemon you should use the following script:

```sh
$ script/untiedconsumerd start
```

For more information: ``script/untiedconsumerd -h``.

## Configuration

### Static assets and AWS

In production mode it's necessary to create a file config/s3.yml in order to sync compiled static assets to S3 buckets:

```yaml
production:
  access_key_id: 'ccc'
  secret_access_key: 'xxx'
  bucket: 'redu.apps.production'
```

### Core communication

You need to inform the Client Application ID from core serice. To do so, add the following configuration on config/application.rb or in environment specific configuration:

```ruby
config.client_application = {
  :secret => 'xxx'
}
```

More information is avalible [here](https://github.com/rumblelabs/asset_sync).

## Technologies and Versions
* Ruby 1.9.3
* Rails 3.2.5
* MySQL Database Manager

## Relied on Libraries
* [Rails](https://github.com/rails/rails)
* [MySQL2](http://rubygems.org/gems/mysql2)
* [Paperclip](https://github.com/thoughtbot/paperclip)
* [Simple_Enum](https://github.com/lwe/simple_enum)
* [FactoryGirlRails](https://github.com/thoughtbot/factory_girl_rails)
* [TheRubyRacer](https://github.com/cowboyd/therubyracer)
* [RspecRails](https://github.com/rspec/rspec-rails)
* [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers)
* [Random Data](https://github.com/tomharris/random_data)
* [Faker](https://github.com/stympy/faker)
* [rails-translate-routes](https://github.com/francesc/rails-translate-routes)
* [Kaminari](https://github.com/amatsuda/kaminari)
* [Simple Navigation](https://github.com/andi/simple-navigation)
* [Sunspot](https://github.com/outoftime/sunspot)

## Contributing

### Run specs
That's not that hard:
```shell
rspec
```
We do not like a million migrations among our project files. That's why you perhaps may find some issues while trying to run the specs. If that's the case, run our rake task for cleaning and putting your DB just as if it wanted to work:
```shell
rake db:prepare
```
