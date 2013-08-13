# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth #ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s nocaseglob
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#PROMPT_COMMAND='CurDir=`pwd|sed -e "s!$HOME!~!"|sed -re "s!([^/])[^/]+/!\1/!g"`'
PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'
PS1="[\u@\h: \$CurDir] \$ "
#PS1='[\u@\h: \W]\$ '
#PS1="\n\[\033[0;30m\]\[\033[1;34m\](\[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;34m\])\[\033[0;30m\] \[\033[1;30m\](\[\033[0;37m\]$OSTYPE\[\033[1;30m\])\[\033[0;30 m\] \[\033[1;31m\](\[\033[1;34m\]\t \d\[\033[1;31m\])\[\033[0;30m\] \[\033[0;30m\]\n \[\033[1;30m\](\[\033[1;37m\]\w/\[\033[1;30m\])\[\033[0;30m\]\[\033[0;32m\] "

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# directory management
source ~/bin/z.sh 

# awesome prompt
source ~/liquidprompt/liquidprompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # install  colordiff package :)
    alias diff='colordiff'
fi

alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'

alias cls='clear'
alias rm='rm -iv'
alias cp='cp -v'
alias mv='mv -v'

alias vi='vim'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias today='date +"%d-%m-%Y"'

alias mount='mount |column -t'


alias urxvt='urxvtc'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

winprop(){
    xprop |awk '/^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print} /^WM_NAME/{sub(/.* =/, "title:"); print}'
}

#export JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#export PATH=$PATH:$HOME/libs/google_appengine
export EDITOR="vim"

#Login greeting ------------------
#if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
#  detached_screens=`screen -list | grep Detached`
#  if [ ! -z "$detached_screens" ]; then
#    echo "+---------------------------------------+"
#    echo "| Detached screens are available:       |"
#    echo "$detached_screens"
#    echo "+---------------------------------------+"
#  else
#    echo "[ screen is activated ]"
#  fi
#  export SHOWED_SCREEN_MESSAGE="true"
#fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export SVN_MERGE=vimdiff

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

