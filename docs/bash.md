# Bash Configuration Documentation

Modern bash 5.3+ configuration with enhanced history, completions, and integrations.

## Overview

The bash configuration is split across four files:
- **`.bash_profile`** - Login shell entry point (sources `.bashrc`)
- **`.bashrc`** - Interactive shell configuration
- **`.inputrc`** - Readline configuration (completions, keybindings)
- **`.shell_common.sh`** - Shared configuration with zsh

## Features

- **Modern bash 5.3+ options** - autocd, globstar, dirspell, erasedups, checkjobs, progcomp_alias
- **Enhanced history** - 50k in memory, 100k on disk, timestamps
- **Smart completions** - Readline configuration (.inputrc) with case-insensitive, colorized completions
- **History search** - Up/Down arrow search, fzf-powered Ctrl+R
- **Dynamic tool detection** - Works on Apple Silicon and Intel Macs
- **Lazy-loading** - nvm loads on first use (200-500ms startup improvement)
- **Version managers** - pyenv, jenv, nvm integrated
- **Debug enhancement** - PS4 with file:line:function output

## File Structure

### `.bash_profile` (Login Shell)

```bash
# Entry point for login shells
# Runs: pyenv init --path (must be in profile)
# Then sources: ~/.bashrc
```

Purpose:
- Set up PATH before interactive shell
- Initialize pyenv paths
- Source `.bashrc` for interactive features

### `.bashrc` (Interactive Shell)

Main configuration file for interactive bash sessions.

```bash
# 1. Source common configuration
[ -f ~/.shell_common.sh ] && source ~/.shell_common.sh

# 2. Bash-specific options (history, shell opts)
# 3. Bash completions
# 4. Prompt configuration
```

### `.inputrc` (Readline Configuration)

Readline settings for all readline-enabled programs (bash, python, mysql, psql, etc.):
- Completion behavior
- History search keybindings
- Display settings

### `.shell_common.sh` (Shared Configuration)

Shared between bash and zsh:
- Environment variables
- PATH configuration
- Aliases
- Functions
- Tool initializations (pyenv, jenv, nvm, etc.)

## Shell Options

### History Configuration

```bash
HISTCONTROL=ignoreboth:erasedups  # Ignore duplicates, erase previous dups
HISTSIZE=50000                    # Lines in memory
HISTFILESIZE=100000               # Lines on disk
HISTTIMEFORMAT='%F %T '           # Timestamp format: YYYY-MM-DD HH:MM:SS

shopt -s histappend               # Append to history file
```

**Features:**
- Ignores duplicate commands
- Erases all previous duplicates (not just adjacent)
- Ignores commands starting with space
- Timestamps for every command
- Multiple terminals share history

### Modern Shell Options (bash 4.0+)

```bash
shopt -s checkwinsize    # Update LINES/COLUMNS after each command
shopt -s nocaseglob      # Case-insensitive globbing
shopt -s cdspell         # Autocorrect typos in cd paths
shopt -s dirspell        # Autocorrect typos in directory completion
shopt -s extglob         # Extended glob patterns (?() *() +() @() !())
shopt -s globstar        # ** for recursive globbing
shopt -s autocd          # cd by typing directory name

set -o noclobber         # Prevent accidental file overwrite (use >| to override)

# Enhanced debug output (when using bash -x)
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
```

### Bash 5.1+ Options

```bash
# Bash 5.1+ options (with version check)
if [[ ${BASH_VERSINFO[0]} -eq 5 && ${BASH_VERSINFO[1]} -ge 1 ]] || [[ ${BASH_VERSINFO[0]} -gt 5 ]]; then
    shopt -s checkjobs        # Warn about stopped jobs before exit
    shopt -s progcomp_alias   # Enable completion for aliases
    shopt -s direxpand        # Expand directory names during completion
    shopt -s globasciiranges  # Use ASCII ordering for ranges
fi
```

**Features:**
- `checkjobs` - Warns "There are stopped jobs" when trying to exit
- `progcomp_alias` - Tab completion works for aliases too
- `direxpand` - `~/Doc<tab>` expands to `~/Documents` immediately
- `globasciiranges` - `[a-z]` always means lowercase ASCII (not locale-dependent)

### Debug Mode

Enhanced PS4 for better script debugging:

```bash
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
```

**Usage:**
```bash
bash -x script.sh
# Output: +(script.sh:10): main(): echo "Hello"
```

Shows file name, line number, and function name for each command.

## Readline Configuration (.inputrc)

Readline settings apply to **all** readline-enabled programs (bash, python REPL, mysql, psql, etc.).

See [inputrc.md](inputrc.md) for complete Readline documentation including:
- Completion settings (case-insensitive, colorized, etc.)
- History search bindings (Up/Down arrow search)
- Display settings
- Custom key bindings
- Advanced configuration

**Quick reference:**
- Up/Down arrows search history based on typed prefix
- Tab completion is case-insensitive and colorized
- File type indicators shown (@=symlink, *=executable, /=directory)

## Completions

Bash completion v2 via Homebrew with dynamic path detection:

```bash
# Detects Homebrew prefix (Apple Silicon or Intel)
BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"

# Homebrew bash-completion v2
if [[ -n "$BREW_PREFIX" && -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
    source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
# Linux bash-completion v2
elif [[ -r "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
# Fallback to v1
elif [[ -r "/etc/bash_completion" ]]; then
    source "/etc/bash_completion"
fi
```

Install completions:
```bash
brew install bash-completion@2
```

## Prompt

Simple, informative prompt with color support:

```bash
# Color prompt if terminal supports it
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi
```

**Format:** `user@host:~/path$`
- Green username@hostname
- Blue current path
- Non-color fallback for basic terminals

## Version Managers

### pyenv (Python)

**Two-stage initialization** (pyenv v2.0+ style):

1. **`.bash_profile`** (login shell):
```bash
eval "$(pyenv init --path)"
```

2. **`.shell_common.sh`** (interactive shell):
```bash
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"  # bash only
fi
```

Usage:
```bash
pyenv install 3.11.7
pyenv global 3.11.7
pyenv virtualenv 3.11.7 myproject
pyenv activate myproject
```

### jenv (Java)

```bash
if command -v jenv &> /dev/null; then
    eval "$(jenv init -)"
fi
```

Usage:
```bash
jenv add /path/to/jdk
jenv global 17
jenv local 11
```

### nvm (Node) - Lazy Loading

**Performance optimization:** nvm loads only when first needed.

```bash
# Wrapper functions that load nvm on first call
nvm() {
    unset -f nvm node npm npx
    [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && source "$BREW_PREFIX/opt/nvm/nvm.sh"
    nvm "$@"
}

# Similar for node, npm, npx
```

**Benefit:** Shell startup 200-500ms faster.

Usage:
```bash
nvm install 20
nvm use 20
nvm alias default 20
```

## Aliases

### Modern CLI Tools

```bash
# eza (modern ls)
alias ls='eza'
alias ll='eza -lhF --git'
alias la='eza -lhaF --git'
alias tree='eza --tree'

# bat (modern cat)
alias cat='bat --paging=never'
alias less='bat --paging=always'

# ripgrep (modern grep) - not aliased to avoid breaking scripts
# Use 'rg' directly for better performance
```

**Note:** `grep` is NOT aliased to `rg` because they have incompatible flags. Use `rg` directly when you want ripgrep's features.

### Navigation

```bash
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"  # Previous directory
```

### Safety

```bash
alias rm='rm -iv'   # Interactive, verbose
alias cp='cp -v'    # Verbose
alias mv='mv -v'    # Verbose
```

### System

```bash
# macOS only
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias macjava='/usr/libexec/java_home -V'
```

## Functions

### Calculator

```bash
calc() { echo "$*" | bc -l; }
```

Usage:
```bash
calc 2+2
calc "scale=4; 22/7"
```

### Tmux Integration

See [tmux.md](tmux.md) for full tmux function documentation.

```bash
ts [session]   # Sesh connect
tn [name]      # New session for current directory
tk [session]   # Kill session
tw             # Switch sessions (inside tmux)
tls            # List sessions
```

## Environment Variables

### XDG Base Directory

```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
```

### Editor and Pager

```bash
export EDITOR="vim"
export PAGER="less"
export LESS="-R -F -X -i"  # Raw colors, quit if one screen, no init, case-insensitive
```

**Note:** `bat` is aliased to `less` for enhanced paging with syntax highlighting.

### FZF Configuration

```bash
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

### Colors

Modern LS_COLORS using `vivid`:

```bash
# Use vivid for modern, maintainable LS_COLORS (if available)
if command -v vivid &> /dev/null; then
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
else
    # Fallback to reasonable defaults
    export LS_COLORS='di=34:ln=36:so=35:pi=33:ex=32:bd=33:cd=33:su=31:sg=31:tw=34:ow=34'
fi
```

**vivid** generates beautiful, theme-consistent LS_COLORS. Catppuccin Mocha theme is used by default.

## PATH Configuration

Dynamic PATH setup that works on both Apple Silicon and Intel Macs:

```bash
# Homebrew (auto-detects /opt/homebrew or /usr/local)
if [[ -n "$BREW_PREFIX" ]]; then
    PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
fi

# User bins
[[ :$PATH: == *:$HOME/bin:* ]] || PATH="$HOME/bin:$PATH"
PATH="$PATH:$HOME/.local/bin"

# Version managers
[ -d "$HOME/.jenv/bin" ] && PATH="$HOME/.jenv/bin:$PATH"

# Node/Yarn
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH
```

## Tool Integrations

These tools are shared between bash and zsh. See [tools.md](tools.md) for complete documentation.

### zoxide (Smart cd)

```bash
eval "$(zoxide init bash)"
```

**Quick reference:**
```bash
z src           # Jump to ~/src
z dot           # Jump to ~/src/dot_files (frecency-based)
zi              # Interactive mode with fzf
```

See [tools.md](tools.md#zoxide---smart-cd) for full documentation.

### fzf (Fuzzy Finder)

```bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
```

**Key bindings** (automatically configured):
- `Ctrl+R` - **Fuzzy history search** (much better than default!)
- `Ctrl+T` - File finder
- `Alt+C` - Directory finder

**Combined with .inputrc:**
- `Up/Down` - Search history based on typed prefix
- `Ctrl+R` - Full fuzzy search across all history

See [tools.md](tools.md#fzf---fuzzy-finder) for full documentation.

### direnv (Directory Environments)

```bash
eval "$(direnv hook bash)"
```

**Quick reference:**
```bash
# Create .envrc in project
echo 'export DATABASE_URL="postgres://localhost/mydb"' > .envrc
direnv allow
```

See [tools.md](tools.md#direnv---directory-environments) for full documentation.

## Local Configuration

For machine-specific or private configs, create `~/.shell_local`:

```bash
# ~/.shell_local (not tracked in git)

# Private aliases
alias wls='ls ~/.whisper/secrets/app'

# Work-specific environment
export GH_HOST=github.enterprise.com

# Source work-specific helpers
[ -f "$HOME/src/work-helpers/helpers.sh" ] && source "$HOME/src/work-helpers/helpers.sh"
```

This file is:
- Sourced automatically by `.shell_common.sh`
- Not tracked in git
- Machine-specific

## Troubleshooting

### Bash Deprecation Warning on macOS

```bash
export BASH_SILENCE_DEPRECATION_WARNING=1
```

Already configured in `.bashrc` for macOS.

### Completion Not Working

Check bash version:
```bash
bash --version  # Should be 5.3+
```

Install bash-completion:
```bash
brew install bash-completion@2
```

Verify it's sourced:
```bash
type _completion_loader
```

### History Not Saving

Check file permissions:
```bash
ls -la ~/.bash_history
```

Force save:
```bash
history -a
```

### pyenv Not Found

Check PATH:
```bash
echo $PATH | grep pyenv
```

Verify installation:
```bash
ls -la ~/.pyenv
```

Re-initialize:
```bash
source ~/.bash_profile
```

### nvm Slow Startup

Lazy-loading is already configured. If still slow, check:
```bash
type nvm
# Should show: nvm is a function (wrapper)
```

## Tips and Tricks

### History Search

```bash
# Fuzzy search entire history (fzf-powered)
Ctrl+R

# Search based on typed prefix (readline)
git<Up>     # Shows previous git commands
cd<Up>      # Shows previous cd commands

# Navigate all history
Up/Down arrows (on empty line)

# Last command
!!

# Last argument of previous command
!$

# All arguments of previous command
!*
```

### Glob Patterns

With `shopt -s extglob`:

```bash
# Match any .jpg or .png
ls *.@(jpg|png)

# Match anything except .txt
ls !(*.txt)

# Match zero or more occurrences
ls file?(1|2|3).txt

# Recursive (with globstar)
ls **/*.md
```

### Noclobber Override

```bash
# Prevent overwrite
echo "test" > file.txt  # Error if file exists

# Force overwrite
echo "test" >| file.txt
```

### Command Editing

```bash
# Edit current command in $EDITOR
Ctrl+X Ctrl+E

# Clear line
Ctrl+U

# Clear from cursor to end
Ctrl+K
```

## Resources

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Bash Hackers Wiki](https://wiki.bash-hackers.org/)
- Related docs:
  - [inputrc.md](inputrc.md) - Readline configuration
  - [tools.md](tools.md) - Shared tools (fzf, zoxide, etc.)
  - [tmux.md](tmux.md) - Tmux configuration
  - [git.md](git.md) - Git configuration
- Config files:
  - `~/.bash_profile` - Login shell entry point
  - `~/.bashrc` - Interactive bash configuration
  - `~/.inputrc` - Readline configuration (completions, keybindings)
  - `~/.shell_common.sh` - Shared with zsh
