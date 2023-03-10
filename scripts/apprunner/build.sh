#!/bin/bash

ln -sf /usr/share/zoneinfo/Japan /etc/localtime
amazon-linux-extras install -y postgresql14
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
yum install -y postgresql-devel nodejs ImageMagick
export RAILS_ENV=production
export BUNDLE_WITHOUT=development:test
export SECRET_KEY_BASE=dummy
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
