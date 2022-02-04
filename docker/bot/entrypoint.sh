#!/bin/sh
set -e

bundle check || bundle install
bundle exec rake db:create || true
bundle exec rake db:migrate

exec "$@"
