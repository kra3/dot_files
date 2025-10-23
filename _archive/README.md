# Archived Legacy Dotfiles

This directory contains legacy configuration files from the pre-chezmoi era (2014-2021).

## Archived on: October 22, 2025

## Why Archived?

These files are preserved for historical reference and comparison with modern configs.

### Linux GUI Configs (macOS not applicable)
- **i3/** - i3 window manager config
- **dwm.desktop** - DWM desktop entry
- **conky/** - Conky system monitor
- **x11/** - X11 display server configs

### Legacy Configs (Modernized Versions Active)
- **git/** - Old git config → Now `dot_gitconfig.tmpl` with delta/absorb/difftastic
- **tmux/** - Old tmux config → Now `dot_tmux/` with modern 3.5a setup

### Obsolete Tools
- **irssi/** - IRC client (no longer used)
- **hg/** - Mercurial VCS configs (git is standard)
- **virtualenv_wrapper_hooks/** - Python virtualenv hooks (consider poetry/uv)

### Git Submodules
- **.gitmodules** - References to external git repositories (historical)

## Removed (Modern Replacements Exist)

These were removed as they're completely replaced by modern tools:
- ~~screen~~ → Replaced by **tmux**
- ~~autojump~~ → Replaced by **zoxide**
- ~~fasd~~ → Replaced by **zoxide**
- ~~liquidprompt~~ → Use modern prompts (starship, etc.)

## Access

These files are preserved for historical reference:
- Git tag: `v1-legacy`
- Git branch: `pre-chezmoi-backup`

## Migration Notes

See main `README.md` for modern setup using chezmoi.
