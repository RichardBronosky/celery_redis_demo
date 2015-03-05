#!/usr/bin/env bash

HASHES=$(docker ps -q);
if [[ -n $HASHES ]]; then
  echo; echo
  echo "Forcefully removing all running containers..."
  docker rm -f $HASHES
fi

DIR="$( cd "$( dirname "$0" )" && pwd )"
$DIR/cleanup_containers.sh
