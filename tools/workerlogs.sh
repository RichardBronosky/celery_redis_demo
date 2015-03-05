
[[ -z $TIMEOUT ]] && TIMEOUT=6

changed(){
  STATE_PREV="$STATE_LAST"
  STATE_LAST="$(stat -f %z /tmp/worker.*)"
  [[ "$STATE_PREV" != "$STATE_LAST" ]]
}

cleanup(){
kill $(jobs -rp); wait $(jobs -rp) 2>/dev/null
rm /tmp/worker.*
}

trap "cleanup; echo; echo;" EXIT

# create new logs for each worker container
for w in $(docker ps | grep -oE "worker-\w*"); do  docker logs --follow --tail=0 $w >/tmp/worker.$w 2>&1 & done;

# watch what happens on each docker container
tail -f -n0 /tmp/worker* &

# since tail -f runs until killed, let's be clever about how long to let it run
while changed; do
  sleep $TIMEOUT
done

echo -e "\nNo change in $TIMEOUT seconds. Presumed complete!\n"
cleanup
