Development Guide
=================

Software Dependencies (OS X)
----------------------------

```bash
$ brew install postgres redis imagemagick pkg-config
```

Setup
-----

```
$ bundle install
$ cp config/application.yml.example config/application.yml
$ cp config/database.yml.example config/database.yml
$ rake db:setup dev:fake
$ rails server
```

Tasks
-----

* `rake dev:fake[model_name,count]`

    dev:fake to generate fake data for all model, dev:fake[course,3] to create 3 fake courses (available parameters: author, post, speaker, category, course, faq)

Coding Rules
============

Generate Admin Pages for Models
-------------------------------

For example, to generate admin pages for `Post` model:

```bash
$ rails generate model post title content:text
$ rails generate scaffold admin/post title content:text --migration=false --parent=post
```

Schema Changing
---------------

1. Generate migraion file
2. Update facotry
3. Update `_form.html.erb`, `show.html.erb` and `index.html.erb` in admin pages.

# `db/schema.rb` MUST BE CONSISTENT in every environment, both servers and clients. Having differnt content is totally not forgivable.

Assets
------

Assets are managed by [gistyle](https://github.com/tonytonyjan/gistyle) framework (DOM-based routing of Javascript), please follow the convension to keep your code clean. Do not mess them up with view files as much as possible.

Principle of Least Gems
-----------------------

Do not easily install gems unless you are familiar with them, generally, functions can be almost accomplished by Rails it self, so think twice before doing.

If you don't like the rules above, you are welcome to challenge [@tonytonyjan](https://github.com/tonytonyjan).

Contact
=======

- hi@5xruby.tw