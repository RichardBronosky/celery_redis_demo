#!/usr/bin/env bash

read -p "How many tests would you like to run? Default is 40: " NUMBER_OF_TESTS
[[ -z $NUMBER_OF_TESTS ]] && NUMBER_OF_TESTS=40

#CMD="docker run --rm --link redis-server:redis.local rbronosky/celery-redis-demo celery_test"
CMD="docker run --rm --link redis-server:redis.local richardbronosky/celery-redis-demo celery_test"

if [[ -n $(docker images -q richardbronosky/celery-redis-demo) ]]; then
  # make $NUMBER_OF_TESTS requests
  x=0; y=$((10**${#NUMBER_OF_TESTS}))
  while [[ $x -lt $NUMBER_OF_TESTS ]]; do
    x=$((x+1))
    echo "requesting test $x"
    $CMD $x $y &
  done 2>&1 > /tmp/worker.results # record what happens in this container just as we do the worker containers
else
  echo; echo
  echo "Failed to locate image richardbronosky/celery-redis-demo"
  echo "Try pulling it with:"
  echo "docker pull richardbronosky/celery-redis-demo"
  echo
fi
