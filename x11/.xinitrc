#!/usr/bin/env bash

sleep 15 && conky | while read -r; do xsetroot -name "$REPLY"; done &

trayer --edge top --align center --SetDockType true --SetPartialStrut true    --expand true --widthtype request --transparent true --tint 0xffffff --height 6 &

nm-applet --sm-disable &

feh --bg-scale ~/.dwm.jpg &

xrdb -merge ~/.Xresources

xautolock -time 5 -locker i3lock &

#eval "$(gpg-agent --daemon)" &
eval `ssh-agent`

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
  SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

~/bin/notify-listener.py & 


#while true; do
#   # Log stderror to a file 
#   dwm 2> ~/.dwm.log
#   # No error logging
#   #dwm >/dev/null 2>&1
#done
