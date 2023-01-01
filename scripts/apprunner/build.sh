#!/bin/bash

amazon-linux-extras install -y postgresql14
yum install -y postgresql-devel
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
