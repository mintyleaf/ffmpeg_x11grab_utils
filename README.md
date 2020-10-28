# ffmpeg x11grab utils

a two simple utils for taking shots or videos of screen or windows  
(based on dylanaraps screenshot script)

## usage

`scr.sh`/`vid.sh` - takes screenshot/screenvideo of whole active screen by default

 flags:  
`--win` - takes screenshot/screenvideo of clicked window  
`--nomouse` - hides mouse from screenshot/screenvideo

## deps

ffmpeg - for grabbing  
xdotools - for getting windows dimensions  
disputils - for getting active display dimensions  
xclip - for placing current screenshot to clipboard
