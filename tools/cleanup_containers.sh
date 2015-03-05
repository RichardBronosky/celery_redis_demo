#!/usr/bin/env bash

HASHES=$(docker ps -a -q -f status=exited);
if [[ -n $HASHES ]]; then
  echo; echo
  echo "Removing all exited containers..."
  docker rm $HASHES
fi
