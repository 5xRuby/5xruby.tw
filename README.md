Official Website of 5xRuby: http://5xruby.tw
=============================================

Development Guide
------------------

### software dependencies (OS X)

**Remember to follow the instructions in Caveats given after brew install**

Install PostgreSQL:

```bash
$ brew install postgres
```

Install Redis:

```bash
$ brew install redis
```

For rmagick gem, will need to install imagemagick and pkg-config:

```bash
$ brew install imagemagick
$ brew install pkg-config
```

### Install all gems

```bash
$ bundle install
```

### Setup your application

```bash
$ cp config/application.yml.example config/application.yml
$ cp config/database.yml.example config/database.yml
$ rake db:setup
$ rake db:migrate
```

### Run your application

```bash
$ rails server
```

Your server will be up and running at: http://localhost:3000/.

### Generate Fake Data in Development Environment

* 1. Generate all fake data for development environment:

```bash
$ rake dev:fake
```

* 2. Generate 3 fake courses:

```bash
$ rake dev:fake[course,3]
```

### Generate Admin Pages for Models

For example, to generate admin pages for `Post` model:

```bash
$ rails generate model post title:string content:text
$ rails generate scaffold admin/post title:string content:text --migration=false --parent=post
```

Contact
-------

hi@5xruby.tw