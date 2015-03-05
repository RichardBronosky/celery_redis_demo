# celery-redis-demo
simple demonstration of using Redis backed Celery workers in Docker containers

--------

This project backs the Docker Hub Automated Build of <https://registry.hub.docker.com/u/richardbronosky/celery-redis-demo/>


### Tools included in this project

 - tools/run.sh
   - Runs this project (containers: redis, celery workers, celerybeat) as intended

 - tools/test.sh
   - Runs a single test in an interactive container

 - tools/loadtest.sh
   - Places a specified number of jobs in the work queue

 - tools/workerlogs.sh
   - Monitors logs of all worker containers

 - tools/nuke_running_containers.sh
   - Forcefully kills running containers then removes exited containers.

 - tools/cleanup_containers.sh
   - Removes exited containers

 - tools/cleanup_images.sh
   - Prompts you to remove every image
