# celery-redis-demo
simple demonstration of using Redis backed Celery workers in Docker containers

--------

This project backs the Docker Hub Automated Build of
<https://registry.hub.docker.com/u/richardbronosky/celery-redis-demo/>

### How to use this project

Study it. There are many [things you can learn from this project]. But if you
want to dive in, clone the repo (or [download the archive]) and run the [run.sh]
script. It will explain to you what it's doing and offer next steps. You can
view the source, but basically it does this:

 - Start a Redis container, downloading [the official Redis image] if you don't
   already have one.

        docker run -d --name redis-server redis

 - Start a few Celery containers, downloading [the image] if you haven't built
   one from [the Dockerfile]

        docker run -d --name worker-1    --link redis-server:redis.local richardbronosky/celery-redis-demo

   - Note that unlike the next command, this one doesn't specify a command to
     run with the container. The Docker file specifies [the default command] for
     us.

 - Start a single Celerybeat container using the same image but a different
   command within it.

        docker run -d --name worker-beat --link redis-server:redis.local richardbronosky/celery-redis-demo celery_test_beat

   - These celery\_test\_\* commands are available because [the Dockerfile uses
     pip] to install the package [celery_test] which [creates a few scripts] and
     places them in the $PATH of the container thanks to some [setuptools
     magic]. (I think this is my favorite part!)

Now that you see what the first tool does, check out some of the other tools
I've included. I won't put their source code in the README. That would get a bit
tiresome.

### Tools included in this project

 - [tools/run.sh][run.sh]
   - Runs this project (containers: redis, celery workers, celerybeat) as intended

 - [tools/test.sh][test.sh]
   - Runs a single test in an interactive container

 - [tools/loadtest.sh][loadtest.sh]
   - Places a specified number of jobs in the work queue

 - [tools/workerlogs.sh][workerlogs.sh]
   - Monitors logs of all worker containers

 - [tools/nuke\_all\_containers.sh][nuke_all_containers.sh]
   - Forcefully kills running containers then removes exited containers.

 - [tools/cleanup\_containers.sh][cleanup_containers.sh]
   - Removes exited containers

 - [tools/cleanup\_images.sh][cleanup_images.sh]
   - Prompts you to remove every image

### Things you can learn from this project 

 - Docker
   - using --link to create network connections between containers
   - running commands inside containers

 - Dockerfile
   - using FROM to build images iteratively
   - using official images
   - using CMD for images that "just work"

 - Celery
   - using Celery without Django
   - using Celerybeat without Django
   - using Redis as a queue broker
   - project layout
   - task naming requirements

 - Python
   - proper project layout for setuptools/setup.py
   - installation of project via pip
   - using entry_points to make console_scripts accessible
   - using setuid and setgid to de-escalate privileges for the celery deamon


  My list of things learned goes far beyond this, but not all those things made
  it into this demo. I strongly suggest taking on creating a tutorial for
  something where you find the existing documentation inadequate for your own
  learning.

[things you can learn from this project]: #things-you-can-learn-from-this-project
[run.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/run.sh
[download the archive]: https://github.com/RichardBronosky/celery_redis_demo/archive/master.zip
[the official redis image]: https://registry.hub.docker.com/u/library/redis/
[the image]: https://hub.docker.com/u/richardbronosky/celery-redis-demo/
[the Dockerfile]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/celery-redis-demo/Dockerfile
[the default command]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/celery-redis-demo/Dockerfile#L7
[the Dockerfile uses pip]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/celery-redis-demo/Dockerfile#L5
[celery_test]: https://github.com/RichardBronosky/celery_test
[creates a few scripts]: https://github.com/RichardBronosky/celery_test/blob/master/setup.py#L69-72
[setuptools magic]: https://pythonhosted.org/setuptools/setuptools.html#automatic-script-creation
[test.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/test.sh
[loadtest.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/loadtest.sh
[workerlogs.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/workerlogs.sh
[nuke_all_containers.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/nuke_all_containers.sh
[cleanup_containers.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/cleanup_containers.sh
[cleanup_images.sh]: https://github.com/RichardBronosky/celery_redis_demo/blob/master/tools/cleanup_images.sh

