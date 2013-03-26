#!/usr/bin/env bash

sleep 15 && conky | while read -r; do xsetroot -name "$REPLY"; done &

trayer --edge top --align right --SetDockType true --SetPartialStrut true    --expand true --width 2 --transparent true --tint 0x000000 --height 6 &

nm-applet --sm-disable &

feh --bg-scale ~/.dwm.jpg &

xrdb -merge ~/.Xresources

xautolock -time 5 -locker i3lock &

#eval "$(gpg-agent --daemon)" &
eval `/usr/bin/ssh-agent`

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
  SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

#while true; do
#   # Log stderror to a file 
#   dwm 2> ~/.dwm.log
#   # No error logging
#   #dwm >/dev/null 2>&1
#done
