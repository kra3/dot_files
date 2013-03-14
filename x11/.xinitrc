#!/bin/sh
#
# ~/.xinitrc


feh --bg-scale Arch.jpg &
xautolock -time 5 -locker i3lock &

#eval "$(gpg-agent --daemon)" &
eval `/usr/bin/ssh-agent`

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
  SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

