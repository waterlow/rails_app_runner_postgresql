#!/bin/bash

bin/rails db:migrate
bundle exec puma -t 5:5 -p 3000
