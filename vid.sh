#!/bin/sh
#
# Take a screenvideo.

vid_dir=~/Videos

date=$(date +%F)
time=$(date +%I-%M-%S)
file=$vid_dir/$date/$date-$time.mp4

mkdir -p "$vid_dir/$date"

if [ "$1" = "--win" ]
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

trap 'cp -f "$file" "$vid_dir/current.mp4"' INT
ffmpeg -y \
    -hide_banner \
    $DRAW_MOUSE \
    -an \
    -f x11grab \
    -v quiet -stats \
    -video_size "$(echo "$WIDTH + $WIDTH % 2" | bc)"x"$(echo "$HEIGHT + $HEIGHT % 2" | bc)" \
    -i :0.0+"$X","$Y" \
    -pix_fmt yuv420p \
    -framerate 30 \
    "$file"

cp -f "$file" "$vid_dir/current.mp4"
