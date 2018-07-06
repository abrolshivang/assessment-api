# Steps for Application Setup!

```sh
$ cd <app_dir>
$ cp config/database.yml.example config/database.yml
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ bundle exec rails db:seed
$ bundle exec rails s # foo@bar.com/123456
$ open doc/api/index.html # To see documentation 
```
# Steps to run specs!

```sh
$ bundle exec rails db:create RAILS_ENV=test
$ bundle exec rails db:migrate RAILS_ENV=test
$ bundle exec rspec spec/
```
