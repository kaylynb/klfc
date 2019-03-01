#!/bin/sh
set -eu

script_dir=$(dirname "$0")
tmp_dir=/tmp/macolemak
mkdir "$tmp_dir"

klfc \
	"$script_dir/colemak.json" \
	"$script_dir/mods.json" \
	--xkb "$tmp_dir"

setxkbmap -I "$tmp_dir" -layout 'colemak(basic)' -keycodes 'evdev+colemak(Angle)' -types complete -option ctrl:nocaps -print | xkbcomp -w 0 -I"$tmp_dir" -o macolemak.xkb - -xkb
