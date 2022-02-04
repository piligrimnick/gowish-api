#!/bin/sh
set -e

bundle check || bundle install
bundle exec rake db:migrate

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"
