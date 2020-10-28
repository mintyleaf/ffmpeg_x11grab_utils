#!/bin/sh
#
# Take a screenshot.

scr_dir=~/Pictures/Screenshots

date=$(date +%F)
time=$(date +%I-%M-%S)
file=$scr_dir/$date/$date-$time.jpg

mkdir -p "$scr_dir/$date"

if [ "$1" = "--win" ] || [ "$2" = "--win" ]
then
	eval $(xdotool selectwindow getwindowgeometry --shell)
else
	DATTR=$(dattr xywh $(phd))
	X=$(echo $DATTR | cut -d ' ' -f 1)
	Y=$(echo $DATTR | cut -d ' ' -f 2)
	WIDTH=$(echo $DATTR | cut -d ' ' -f 3)
	HEIGHT=$(echo $DATTR | cut -d ' ' -f 4)
fi

[ "$1" = "--nomouse" ] && DRAW_MOUSE="-draw_mouse 0"
[ "$2" = "--nomouse" ] && DRAW_MOUSE="-draw_mouse 0"

ffmpeg -y \
    -hide_banner \
    $DRAW_MOUSE \
    -loglevel error \
    -f x11grab \
    -video_size $WIDTH"x"$HEIGHT \
    -i :0.0+"$X","$Y" \
    -vframes 1 \
    "$file"

cp -f "$file" "$scr_dir/current.jpg"

sleep 0.1

xclip -sel clip -t image/png < "$scr_dir/current.jpg"
