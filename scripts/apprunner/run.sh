#!/bin/bash

export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true
export BUNDLE_WITHOUT=development:test
bin/rails db:migrate
bundle exec puma -t 5:5 -p 3000
