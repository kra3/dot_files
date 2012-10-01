#!/bin/sh
#
# ~/.xinitrc


feh --bg-scale Arch.jpg &

#eval "$(gpg-agent --daemon)" &
eval `/usr/bin/ssh-agent`

if test -f /usr/lib/ssh/x11-ssh-askpass # Archlinux
then
        SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
  SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

feh --bg-scale Arch.jpg &
