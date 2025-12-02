#!/usr/bin/env bash

_daemon() {
  $(pgrep -a swww-daemon) &&
    return 0 ||
    $(swww-daemon &)
}

# WARNING: Make sure none of the files in the Wallpapers Directory has any spaces in the file name

WALL_DIR="$HOME/Pictures/wallpapers"
IMG_LIST=($(ls $WALL_DIR))

_get_current_index() {
  local CURR_WALL_PATH=$(swww query | cut -d':' -f5)
  CURR_WALL=$(basename $CURR_WALL_PATH)

  for i in ${!IMG_LIST[@]}; do
    if [ ${IMG_LIST[$i]} = ${CURR_WALL} ]; then
      CURR_WALL_INDEX=${i}
      break
    fi
  done
}

_switch() {
  _daemon
  _get_current_index
  swww img $WALL_DIR/${IMG_LIST[${CURR_WALL_INDEX} + 1]} \
    --transition-type random \
    --transition-angle 30 \
    --transition-duration 2 2>/dev/null
}

while getopts "fbs:h" opt; do
  default=false
  case "$opt" in
  f) _switch ;;
  b) echo "back" ;;
  s) echo "said $OPTARG" ;;
  h) echo "help" ;;
  *)
    echo "Invalid option"
    exit 1
    ;;
  esac
done

$default && echo "default" || echo "set"
