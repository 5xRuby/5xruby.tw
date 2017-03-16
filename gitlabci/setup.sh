gem install rubygems-bundler
bundle check --path=${BUNDLE_CACHE} || bundle install --path=${BUNDLE_CACHE} --jobs=2 --retry=3
cp config/application.yml.example config/application.yml
cp gitlabci/database.yml config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate:reset
