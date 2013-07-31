#!/usr/bin/env bash

if [ -d /etc/X11/Xsession.d ]; then
   for f in /etc/X11/Xsession.d/*; do
       [ -x "$f" ] && . "$f"
   done
   unset f
fi

sleep 5 && conky | while read -r; do xsetroot -name "$REPLY"; done &

#trayer --edge top --align center --SetDockType true --SetPartialStrut true    --expand true --widthtype request --transparent true --tint 0xffffff --height 6 &

nm-applet --sm-disable &
gnome-sound-applet &

feh --bg-scale ~/.dwm.jpg &

# This is where Terminus is installed by ubunutu
xset +fp /usr/share/fonts/X11/misc/
xset fp rehash

# Update Xresources - for urxvt and uxterm
xrdb -merge ~/.Xresources &

# Set to lock automatically after 5min of incativity 
xautolock -time 5 -locker i3lock &

# Hide mouse icons after 5sec
unclutter -idle 5 &

# Start urxvt in deamon mode
urxvtd -q -f -o &

# Put number lock key, on startup
numlockx &

# setxkbmap -option 'grp:alt_shift_toggle'
setxkbmap -layout "us, fr" -option "grp:alt_shift_toggle"

~/bin/notify-listener.py & 

# A place for your distro/box specific startup scripts
if [ -f "$HOME/.xinitrc_local" ]; then
   . "$HOME/.xinitrc_local"
fi

exec dwm

#while true; do
#   # Log stderror to a file 
#   dwm 2> ~/.dwm.log
#   # No error logging
#   #dwm >/dev/null 2>&1
#done
