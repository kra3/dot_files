# Zsh Configuration Documentation

Modern zsh 5.9+ configuration with Powerlevel10k, enhanced completions, and performance optimizations.

## Overview

The zsh configuration is split across four files:
- **`.zprofile`** - Login shell entry point (sources `.zshrc`)
- **`.zshrc`** - Interactive shell configuration
- **`.inputrc`** - Readline configuration (for programs that use readline)
- **`.shell_common.sh`** - Shared configuration with bash

## Features

- **Powerlevel10k instant prompt** - Sub-50ms prompt rendering
- **Zinit plugin manager** - Turbo mode loading (zero startup impact)
- **Fish-like autosuggestions** - Suggestions from history as you type
- **Syntax highlighting** - Real-time command validation (green/red)
- **Enhanced completions** - Menu select, colors, caching
- **Modern zsh 5.9+ options** - EXTENDED_HISTORY, HIST_VERIFY, COMPLETE_IN_WORD
- **Performance optimizations** - Completion caching, lazy-loading
- **Advanced history** - 50k in memory, 100k on disk, shared across sessions
- **Dynamic tool detection** - Works on Apple Silicon and Intel Macs

## File Structure

### `.zprofile` (Login Shell)

```bash
# Entry point for login shells
# Runs: pyenv init --path (must be in profile)
# Then sources: ~/.zshrc
```

Purpose:
- Set up PATH before interactive shell
- Initialize pyenv paths
- Source `.zshrc` for interactive features

### `.zshrc` (Interactive Shell)

Order is critical for instant prompt performance:

```bash
# 1. Powerlevel10k instant prompt (MUST be first)
# 2. Detect Homebrew prefix
# 3. Source common configuration
# 4. Completions setup
# 5. History configuration
# 6. Zsh-specific options
# 7. Zinit plugin manager
#    - Load Powerlevel10k theme
#    - Load autosuggestions (turbo mode)
#    - Load syntax-highlighting (turbo mode)
# 8. Key bindings
```

### `.shell_common.sh` (Shared Configuration)

Shared between bash and zsh:
- Environment variables
- PATH configuration
- Aliases
- Functions
- Tool initializations (pyenv, jenv, nvm, etc.)

## Powerlevel10k

### Installation

Powerlevel10k is installed as a Zinit plugin (managed automatically).

### Instant Prompt

**MUST be at the very top of `.zshrc`:**

```bash
# Enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
```

**Performance:** Renders prompt in <50ms while rest of config loads.

### Theme Configuration

Powerlevel10k is loaded via Zinit:

```bash
# Load Powerlevel10k theme (after Zinit is loaded)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Load p10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

### Initial Setup

```bash
# First time: configure prompt
p10k configure

# Reconfigure anytime
p10k configure
```

Configuration is saved to `~/.p10k.zsh`.

## Completions

### Setup

```bash
# Add Homebrew completions to fpath
if [[ -n "$BREW_PREFIX" ]]; then
    fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
fi

# Speed up compinit by checking cache once a day
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qNmh+24) ]]; then
    compinit          # Full check
else
    compinit -C       # Skip check
fi
```

**Performance:** Only checks completion dump once per day.

### Styling

```bash
# Menu selection
zstyle ':completion:*' menu select

# Colorize using LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group by type
zstyle ':completion:*' group-name ''

# Descriptions
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
```

### Usage

```bash
# Trigger completion
Tab

# Navigate menu
Tab / Shift+Tab / Arrow keys

# Accept
Enter

# Cancel
Ctrl+C or Escape
```

## History Configuration

### Settings

```bash
HISTSIZE=50000                # Lines in memory
SAVEHIST=100000               # Lines on disk
HISTFILE=~/.zsh_history       # History file

# Options
setopt EXTENDED_HISTORY          # Timestamps
setopt HIST_IGNORE_ALL_DUPS      # No duplicate entries
setopt HIST_FIND_NO_DUPS         # No duplicates in search
setopt HIST_SAVE_NO_DUPS         # No duplicates on disk
setopt HIST_EXPIRE_DUPS_FIRST    # Expire dups first
setopt HIST_VERIFY               # Show before running history expansion
setopt SHARE_HISTORY             # Share between sessions
setopt APPEND_HISTORY            # Append to file
setopt INC_APPEND_HISTORY        # Write immediately
```

### Features

**Timestamps:**
```bash
history  # Shows timestamps
```

**Verify before running:**
```bash
!123     # Shows command, press Enter again to run
```

**Shared across sessions:**
- All zsh sessions see same history in real-time
- No need to close shell to save history

## Zsh Options

### Completion

```bash
setopt COMPLETE_IN_WORD          # Complete from cursor position
setopt ALWAYS_TO_END             # Move cursor to end after completion
```

### Navigation

```bash
setopt AUTO_CD                   # cd by typing directory name
setopt AUTO_PUSHD                # Push directories onto stack
setopt PUSHD_IGNORE_DUPS         # No duplicates in stack
setopt PUSHD_SILENT              # Don't print stack
```

Usage:
```bash
# Just type directory name
projects   # Same as: cd projects

# Navigate directory stack
dirs -v    # Show stack
1          # cd to directory 1 in stack
cd -       # Previous directory
```

### Correction

```bash
setopt CORRECT                   # Command correction
```

Example:
```bash
gti status
# zsh: correct 'gti' to 'git' [nyae]?
```

## Key Bindings

### Mode

```bash
bindkey -e  # Emacs mode (default)
```

For vi mode: `bindkey -v`

### Custom Bindings

```bash
# Better history search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
```

### Default Bindings

| Key | Action |
|-----|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+U` | Kill line backwards |
| `Ctrl+K` | Kill line forwards |
| `Ctrl+W` | Kill word backwards |
| `Alt+D` | Kill word forwards |
| `Ctrl+L` | Clear screen |
| `Ctrl+R` | History search (reverse) |
| `Ctrl+S` | History search (forward) |

## Version Managers

### pyenv (Python)

**Two-stage initialization** (pyenv v2.0+ style):

1. **`.zprofile`** (login shell):
```bash
eval "$(pyenv init --path)"
```

2. **`.shell_common.sh`** (interactive shell):
```bash
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
    # Note: No virtualenv-init in zsh
fi
```

### jenv (Java)

```bash
if command -v jenv &> /dev/null; then
    eval "$(jenv init -)"
fi
```

### nvm (Node) - Lazy Loading

**Performance optimization:** nvm loads only when first needed (200-500ms improvement).

```bash
# Wrapper functions that load nvm on first call
nvm() {
    unset -f nvm node npm npx
    [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && source "$BREW_PREFIX/opt/nvm/nvm.sh"
    nvm "$@"
}
```

## Aliases

Aliases are defined in `.shell_common.sh` (shared with bash).

### Modern CLI Tools

```bash
alias ls='eza'
alias ll='eza -lhF --git'
alias cat='bat --paging=never'
alias grep='rg'
```

See [bash.md](bash.md#aliases) for complete alias list.

## Functions

Functions are defined in `.shell_common.sh` (shared with bash).

### Calculator

```bash
calc() { echo "$*" | bc -l; }
```

### Tmux Integration

```bash
ts [session]   # Sesh connect
tn [name]      # New session
tk [session]   # Kill session
```

See [tmux.md](tmux.md) for complete tmux function documentation.

## Tool Integrations

These tools are shared between bash and zsh. See [tools.md](tools.md) for complete documentation.

### zoxide (Smart cd)

```bash
eval "$(zoxide init zsh)"
```

**Quick reference:**
- `z <keyword>` - Jump to directory
- `zi` - Interactive mode with fzf

See [tools.md](tools.md#zoxide---smart-cd) for full documentation.

### fzf (Fuzzy Finder)

```bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

**Key bindings** (automatically configured):
- `Ctrl+R` - Command history (enhanced by fzf)
- `Ctrl+T` - File finder
- `Alt+C` - Directory finder

See [tools.md](tools.md#fzf---fuzzy-finder) for full documentation.

### direnv (Directory Environments)

```bash
eval "$(direnv hook zsh)"
```

Automatically loads/unloads environment from `.envrc` files.

See [tools.md](tools.md#direnv---directory-environments) for full documentation.

## Plugins

### Zinit Plugin Manager

The configuration uses **Zinit** to load plugins in turbo mode (zero startup time impact).

**Installation:** Zinit is automatically installed by the provisioning script (`run_once_install-tools.sh`) when you run `chezmoi apply`.

**How it works:**
- Installed to `~/.local/share/zinit/zinit.git`
- Plugins load AFTER the prompt appears (`wait'0'`)
- No startup time penalty (instant prompt remains <50ms)

**Manual installation** (if needed):
```bash
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
mkdir -p "$(dirname "$ZINIT_HOME")"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
```

### Installed Plugins

#### powerlevel10k
Modern, fast zsh theme with instant prompt support.

**Features:**
- Sub-50ms instant prompt
- Git status integration
- Highly customizable segments
- Transient prompt support

**Configuration:**
```bash
# Run configuration wizard
p10k configure

# Edit configuration
vim ~/.p10k.zsh
```

#### zsh-autosuggestions
Fish-like autosuggestions as you type. Suggests commands from history in gray text.

```bash
# Type a command you've used before
git sta
# Gray text appears: git status
# Press → to accept
```

**Key bindings:**
- `→` - Accept full suggestion
- `Ctrl+→` - Accept one word

#### zsh-syntax-highlighting
Real-time command validation with color coding.

```bash
git status      # GREEN (valid command)
gti status      # RED (invalid command)
cd /usr/local   # Path is UNDERLINED (valid)
```

**Features:**
- Green = valid command
- Red = invalid command/typo
- Underline = valid path
- Validates as you type

### Plugin Management

```bash
# Update all plugins
zinit update

# Update specific plugin
zinit update zsh-users/zsh-autosuggestions

# List installed plugins
zinit list

# Self-update zinit
zinit self-update
```

### Adding More Plugins

Edit `~/.zshrc` and add to the Zinit section:

```bash
# Example: History substring search
zinit ice wait'0' lucid
zinit light zsh-users/zsh-history-substring-search

# Example: Load Oh My Zsh plugin
zinit snippet OMZ::plugins/docker/docker.plugin.zsh
```

**Performance:** Turbo mode ensures all plugins load AFTER the prompt appears, maintaining <50ms instant prompt.

## Performance Optimization

### Startup Time

Measure startup time:
```bash
time zsh -i -c exit
```

Target: <200ms (with lazy-loading)

### Profiling

Enable profiling:
```bash
# Add to top of .zshrc
zmodload zsh/zprof

# Add to bottom of .zshrc
zprof
```

### Optimization Tips

1. **Use instant prompt** - Already configured
2. **Cache completions** - Already configured (daily check)
3. **Lazy-load nvm** - Already configured
4. **Avoid slow commands** - Don't run in .zshrc

## Troubleshooting

### Instant Prompt Warnings

If you see instant prompt warnings:

```bash
# Check what's printing before instant prompt
p10k troubleshoot
```

Fix: Move slow commands after instant prompt block.

### Completions Not Working

Rebuild completion cache:
```bash
rm ~/.zcompdump*
compinit
```

### History Not Sharing

Check options:
```bash
setopt | grep SHARE_HISTORY
```

Force reload:
```bash
fc -R
```

### Slow Startup

Profile startup:
```bash
time zsh -i -c exit
```

Common culprits:
- nvm loading (fixed with lazy-loading)
- Checking remote git repos
- Running slow commands

### Plugins Not Loading

Check if Zinit is installed:
```bash
ls -la ~/.local/share/zinit/
```

If missing, Zinit auto-installs on next shell start:
```bash
exec zsh
```

Update plugins:
```bash
zinit update
```

## Advanced Tips

### Directory Stack

```bash
# Push directory
pushd /path/to/dir

# Pop directory
popd

# Show stack
dirs -v

# Jump to stack item
~1    # Go to item 1
```

### Glob Qualifiers

```bash
# List only directories
ls -ld *(/)

# List only files
ls -l *(.)

# List by modification time (newest first)
ls -lt *(om)

# List files modified today
ls -l *(m0)

# List empty files
ls -l *(L0)

# Recursive globbing
ls **/*.md
```

### Parameter Expansion

```bash
# Default value
echo ${VAR:-default}

# Remove extension
echo ${file%.txt}

# Remove path
echo ${file##*/}

# Replace
echo ${string/old/new}
```

### Arrays

```bash
# Create array
arr=(one two three)

# Access
echo $arr[1]    # one (1-indexed!)
echo $arr[@]    # all elements

# Length
echo ${#arr}
```

## Local Configuration

For machine-specific configs, create `~/.shell_local`:

```bash
# ~/.shell_local (not tracked in git)

# Work-specific environment
export GH_HOST=github.enterprise.com

# Source work helpers
[ -f "$HOME/src/work-helpers/helpers.sh" ] && source "$HOME/src/work-helpers/helpers.sh"
```

## Resources

- [Zsh Manual](https://zsh.sourceforge.io/Doc/)
- [Zsh Wiki](https://wiki.archlinux.org/title/Zsh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Zinit](https://github.com/zdharma-continuum/zinit)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- Related docs:
  - [inputrc.md](inputrc.md) - Readline configuration (for bash, python, etc.)
  - [tools.md](tools.md) - Shared tools (fzf, zoxide, etc.)
  - [bash.md](bash.md) - Bash configuration
  - [tmux.md](tmux.md) - Tmux configuration
  - [git.md](git.md) - Git configuration
- Config files:
  - `~/.zprofile` - Login shell entry point
  - `~/.zshrc` - Interactive zsh configuration
  - `~/.p10k.zsh` - Powerlevel10k theme
  - `~/.inputrc` - Readline (used by other programs)
  - `~/.shell_common.sh` - Shared with bash
