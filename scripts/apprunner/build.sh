#!/bin/bash

amazon-linux-extras install -y postgresql14
yum install -y postgresql-devel nodejs
export RAILS_ENV=production
export BUNDLE_WITHOUT=development:test
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
