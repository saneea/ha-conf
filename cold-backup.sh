#!/bin/sh

LINE='------------------------------------'
DC='docker compose --progress plain'

log() {
  echo $(./ha-date.sh) "$@"
}

echo $LINE
log start backup
echo

log start pause containers
${DC} pause
log end pause containers
echo

log start sync work tree
./sync-work-tree.sh
log end sync work tree
echo

log start un-pause containers
${DC} unpause
log end un-pause containers
echo

log start creating archive
./backup-work-tree.sh
log end creating archive
echo

log end backup
echo $LINE
echo
echo
