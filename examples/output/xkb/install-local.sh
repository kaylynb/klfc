#!/bin/sh
set -eu

xkb_dir=$(dirname "$0")
layout="colemak"
mod="basic"
warning_level=0

OPTIND=1

while getopts "d:l:m:w:" opt; do
  case "$opt" in
    d) xkb_dir="$OPTARG";;
    l) layout="$OPTARG";;
    m) mod="$OPTARG";;
    w) warning_level="$OPTARG";;
    *) exit 1;;
  esac
done

if [ -z "$layout" ]; then
  echo "Empty layout"
  exit 2
fi

setxkbmap \
    -I "$xkb_dir" \
    -layout "$layout" \
    -keycodes "$layout($mod)" \
    -types "complete+$layout" \
    -compat "complete" \
    -print \
| xkbcomp \
    -w "$warning_level" \
    -I"$xkb_dir" \
    -o /tmp/temp.xkb \
    - -xkb
#    -compat "complete+$layout" \
#    -compat "basic+iso9995+level5" \
#    - "$DISPLAY"
xkbcomp /tmp/temp.xkb -w "$warning_level" -o "$DISPLAY"
rm /tmp/temp.xkb
