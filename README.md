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
