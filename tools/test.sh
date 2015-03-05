#!/usr/bin/env bash

echo; echo
echo "Running a single test..."
read -p "Enter 2 integers separated by a space. Default is 32 16: " v1 v2
docker run --rm -t -i --link redis-server:redis.local richardbronosky/celery-redis-demo celery_test $v1 $v2

