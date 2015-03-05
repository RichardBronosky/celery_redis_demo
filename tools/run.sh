#!/usr/bin/env bash

NUMBER_OF_WORKERS=3
DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR/..

# Start up a redis server in the background (pulls the official image if you don't have it)
echo; echo
echo "Starting a Redis server..."
docker run -d --name redis-server redis

# Start up a few celery worker containers
echo; echo
echo "Starting $NUMBER_OF_WORKERS worker containers. (Celery defaults to number_of_cores workers, so 1 container != 1 worker.)"
for w in $(seq $NUMBER_OF_WORKERS); do
  # using worker-$w in the next command would be simpler, but this way you can
  # copy/paste it into your terminal to run as many as you wish without this script
  docker run -d --name worker-$(($(docker ps | grep -cE 'worker-[0-9]+')+1)) --link redis-server:redis.local richardbronosky/celery-redis-demo
  # NOTE: default CMD for richardbronosky/celery-redis-demo is celery_test_worker
done
echo
echo "To see what containers are running use: docker ps"

# Start up a celerybeat worker
echo; echo
echo "Starting a Celerybeat worker..."
docker run -d --name worker-beat --link redis-server:redis.local richardbronosky/celery-redis-demo celery_test_beat

echo; echo
cat <<EOF
At this point you may want to try one the following...
tools/test.sh          # Run a single
tools/workerlogs.sh    # Inspect the logs of all workers
tools/loadtest.sh      # Run a loadtest
(It is actually recommended that you start watching the logs after you start the loadtest like so...)
tools/loadtest.sh; tools/workerlogs.sh
EOF

