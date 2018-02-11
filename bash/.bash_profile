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

# no accidental overrites by redirection
set -o noclobber

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

test -s "$NVM_DIR/nvm.sh" && source "${NVM_DIR}/nvm.sh"

# make less more friendly for non-text input files, see lesspipe(1)
test -x `command -v lesspipe` && eval "$(SHELL=/bin/sh lesspipe.sh)"

# test -s "$HOME/.autojump/etc/profile.d/autojump.sh"  && source "${HOME}/.autojump/etc/profile.d/autojump.sh"

eval "$(tmuxifier init -)"

eval "$(fasd --init auto)"

eval "$(register-python-argcomplete conda)"

# TODO: May be this should move to .extra 
. /Users/karunagath/anaconda3/etc/profile.d/conda.sh
