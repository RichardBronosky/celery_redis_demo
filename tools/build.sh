DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR/..

# Build the celery image via Dockerfile
docker build -t richardbronosky/celery-redis-demo:latest celery-redis-demo
