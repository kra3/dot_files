#!/usr/bin/env bash

if [ -d /etc/X11/Xsession.d ]; then
   for f in /etc/X11/Xsession.d/*; do
       [ -x "$f" ] && . "$f"
   done
   unset f
fi

nm-applet --sm-disable &
gnome-sound-applet &

semonres  # custom arandr script for my office monitor set-up 
feh --bg-fill ~/.dwm.jpg &

# This is where Terminus is installed by ubunutu
xset +fp /usr/share/fonts/X11/misc/
xset fp rehash

# Update Xresources - for urxvt and uxterm
xrdb -merge ~/.Xresources &

# Set to lock automatically after 5min of incativity 
xautolock -time 5 -locker i3lock &

# Hide mouse icons after 5sec
unclutter -root -idle 5 &

# Start urxvt in deamon mode
urxvtd -q -f -o &

# Put number lock key, on startup
numlockx &

# My use of this clipboard manager is to unify primary copy to clip board
parcellite &

# setxkbmap -option 'grp:alt_shift_toggle'
setxkbmap -layout "us, fr" -option "grp:alt_shift_toggle"

~/bin/notify-listener.py & 

# export CLICOLOR=TRUE 

eval `ssh-agent`

sleep 5 && conky | while read -r; do xsetroot -name "$REPLY"; done &

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx 

# A place for your distro/box specific startup scripts
if [ -f "$HOME/.xinitrc_local" ]; then
   . "$HOME/.xinitrc_local"
fi

session=${1:-dwm}

case $session in
    dwm) exec dwm ;; 
    gnome) exec gnome-session ;;
    cinnamon) exec gnome-session-cinnamon ;;
    *) exec $1;;
esac
