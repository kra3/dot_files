# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

> **Modernized October 2025** - Migrated from manual symlinking to chezmoi-based management with modern tooling.

## Features

- 🖥️ **Cross-platform**: macOS and Linux support
- 🎯 **Environment-aware**: Different configs for work/personal machines
- 🚀 **One-command setup**: Fresh machine provisioning
- 🔧 **Modern tooling**: Latest CLI tools and configurations
- 📦 **Automated installation**: Dependencies installed automatically

## Quick Start

### Fresh Machine Setup (One Command!)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kra3/dot_files
```

On first run, you'll be prompted for:
- Work machine hostname (to detect if this is work or personal machine)
- Email and GitHub username (only for the detected machine type)

Your answers are saved to `~/.config/chezmoi/chezmoi.toml` (not tracked in git).

That's it! Chezmoi will:
1. Detect your OS (macOS/Linux)
2. Detect your hostname (work/personal)
3. Install required tools
4. Apply correct configurations

### Manual Setup

```bash
# Install chezmoi
brew install chezmoi  # macOS
# or
sudo apt install chezmoi  # Linux

# Initialize and apply
chezmoi init https://github.com/kra3/dot_files.git
chezmoi apply
```

### Pre-configuring Without Prompts (Optional)

If you want to skip interactive prompts, create `~/.config/chezmoi/chezmoi.toml` before running `chezmoi init`:

```toml
[data]
    workHostname = "Work-MacBook-Pro"  # Hostname of your work machine
    email = "your.email@example.com"   # Your email (work or personal)
    githubUser = "your-username"       # Your GitHub username (work or personal)
```

This file is:
- Not tracked in git
- Machine-specific
- Persistent across updates

## What's Included

### Currently Managed

- ✅ **Tmux** - Modern tmux 3.5a with Catppuccin theme, sesh, popups, fzf ([docs](docs/tmux.md))
- ✅ **Git** - Delta, git-absorb, difftastic, 50+ aliases ([docs](docs/git.md))
- ✅ **Bash** - Modern bash 5.3+ with enhanced history, completions ([docs](docs/bash.md))
- ✅ **Zsh** - Powerlevel10k, optimized completions, instant prompt ([docs](docs/zsh.md))
- ✅ **Vim** - LSP-powered Vim 9 with 45 plugins, 6 languages, Catppuccin theme ([docs](docs/vim.md))
- ✅ **Terminal.app** - Catppuccin theme for consistent look (macOS)

### Linux Desktop Environment (X11/Wayland)

Modern Linux configurations with unified Catppuccin Mocha theming:

- ✅ **i3** - Tiling window manager with Vim bindings, rofi launcher, Catppuccin theme
- ✅ **X11** - `.xinitrc` session startup, `.Xresources` with URxvt/xterm configs, `.xinputrc` for ibus
- ✅ **irssi** - IRC client with Libera.Chat, SSL/TLS, Perl scripts (4 docs: setup, scripts, themes)
- ✅ **conky** - System monitor (desktop widget + status bar for dwm/i3bar)
- ✅ **dwm** - Desktop entry for display manager session list
- ✅ **Utility scripts** - i3lock-blur (screenshot lock), notify-listener (irssi notifications)

### Tool Configurations

All major CLI tools have been configured with sensible defaults and Catppuccin theming:

- ✅ **lazygit** - Catppuccin Mocha theme, custom keybindings, delta integration
- ✅ **bat** - Catppuccin Mocha syntax highlighting, line numbers, Git diff markers
- ✅ **fd** - Custom ignore patterns, integrated with fzf and tmux
- ✅ **ripgrep** - Smart case, hidden files, comprehensive ignore patterns
- ✅ **GitHub CLI (gh)** - SSH protocol, vim editor, common aliases
- ✅ **colordiff** - Catppuccin-inspired color scheme

### Tools Installed (33 Total)

**Core:**
- `git`, `gh` - Version control and GitHub CLI
- `vim` - Text editor
- `curl`, `jq` - Data transfer and JSON processing
- `node` - JavaScript runtime (includes npm for LSP servers)
- `awscli` - AWS command line interface
- `docker`, `docker-compose` - Container platform

**Terminal Multiplexing:**
- `tmux` - Terminal multiplexer
- `sesh` - Smart session manager

**Navigation & Search:**
- `fzf` - Fuzzy finder
- `fd` - Modern find (fast file/directory search)
- `zoxide` - Smart directory jumper

**Git Tools:**
- `delta` - Modern diff pager
- `git-absorb` - Automatic fixup commits
- `difftastic` - Syntax-aware structural diffs
- `lazygit` - Terminal UI for git

**CLI Tools:**
- `eza` - Modern ls replacement
- `bat` - Modern cat with syntax highlighting
- `ripgrep` - Fast search tool
- `colordiff` - Colorized diff output

**Shell Enhancements:**
- `zsh-completions` - Additional completions
- `vivid` - Modern LS_COLORS generator
- `lesspipe` - Less input preprocessor
- `bc` - Calculator for shell

**Version Managers:**
- `pyenv` - Python version manager
- `jenv` - Java version manager
- `nvm` - Node version manager

**Build Tools:**
- `gng` - Gradle/Maven wrapper (provides `gw` command)

**AI/ML Tools:**
- `ollama` - Local LLM runtime for running AI models

**Plugin Managers:**
- `zinit` - Zsh plugin manager (installs p10k, autosuggestions, syntax-highlighting)
- `tpm` - Tmux plugin manager

### Legacy Configs (Pre-Chezmoi)

See `_archive/README.md` for archived configurations (2014-2021 era).

- Git configurations (`.gitconfig`)
- Bash setup (modular `.bash_profile`, aliases, functions)
- Vim configuration (vim-plug based)
- Custom scripts and binaries

**Note**: Legacy configs will be incrementally migrated to chezmoi.

## Management Commands

```bash
# See what's managed
chezmoi managed

# Preview changes before applying
chezmoi diff

# Apply changes
chezmoi apply

# Edit a file (opens in $EDITOR)
chezmoi edit ~/.tmux/.tmux.conf

# Update from git and apply
chezmoi update

# Re-run install scripts
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

## Theme Configuration

All components use the **Catppuccin Mocha** theme for a consistent, modern look.

### Vim
- **Theme**: Catppuccin Mocha (via `catppuccin/vim` plugin)
- **Setup**: Automatic after running `vim +PlugInstall +qall`
- **Config**: `~/.vimrc` line 245

### Tmux
- **Theme**: Catppuccin Mocha (via `catppuccin/tmux` plugin)
- **Setup**: Install plugins with `Ctrl+a Shift+I` in tmux
- **Config**: `~/.tmux/.tmux.conf`

### bat (Syntax Highlighting)
- **Theme**: Catppuccin Mocha
- **Setup**: Automatic via provisioning script
- **Config**: `~/.config/bat/config`

### Terminal.app (macOS)
- **Theme**: Catppuccin Mocha (4 flavors available)
- **Location**: `~/.config/terminal-themes/`
- **Setup**:
  1. Open Terminal.app
  2. Go to Settings → Profiles
  3. Click the gear icon (⚙️) → Import...
  4. Select: `~/.config/terminal-themes/Catppuccin-Mocha.terminal`
  5. Set as default profile

**Available flavors**: Mocha (dark), Macchiato (dark), Frappe (dark), Latte (light)

## Local/Private Configuration

For machine-specific or private configs (secrets, internal tools), create local config files:

### Shell Configuration: `~/.shell_local`

```bash
# Example ~/.shell_local (not tracked in git)

# Private aliases
alias wls='ls ~/.secrets/app'
wcat() { cat ~/.secrets/app/$1; }

# Internal tools
function internal_cli() {
    docker run -it --rm company.docker.io/cli:latest ...
}

# Work-specific environment variables
export GH_HOST=github.company.com
export WORK_WORKSPACE=$HOME/src/WorkWorkspace
export TOOL_CREDENTIALS=~/.config/tool/credentials.properties

# Machine-specific exports
export INTERNAL_API_KEY="..."

# Source work-specific helpers
[ -f "$HOME/src/work-helpers/helpers.sh" ] && source "$HOME/src/work-helpers/helpers.sh"
```

This file is:
- Sourced by `~/.shell_common.sh`
- Works in both bash and zsh
- Not tracked in git (in `.chezmoiignore`)
- Machine-local only

### Git Configuration: `~/.gitconfig.work`

```ini
# Example ~/.gitconfig.work (not tracked in git)

# Work-specific credential helpers
[credential "https://github.com"]
    helper =
    helper = !gh auth git-credential

[credential "https://github.company.com"]
    helper =
    helper = !gh auth git-credential

# GPG signing with company tools (example)
[gpg "x509"]
    program = /usr/local/bin/company-sign

[commit]
    gpgsign = true

[gpg]
    format = x509
```

This file is:
- Included by `~/.gitconfig` on work machines
- Not tracked in git (in `.chezmoiignore`)
- Work-machine only

### Git Configuration: `~/.gitconfig.local`

```ini
# Example ~/.gitconfig.local (not tracked in git)

[user]
    signingkey = ABCDEF1234567890

[commit]
    gpgsign = true
```

This file is:
- Included by `~/.gitconfig` on all machines
- Not tracked in git (ignored via `.chezmoiignore`)
- Ideal for personal secrets (GPG keys, tokens, extra aliases)

GPG pinentry prompts work in both macOS and Linux shells because `~/.shell_common.sh` exports `GPG_TTY=$(tty)` whenever `gpg` is installed.

## Environment Detection

Chezmoi automatically detects:
- **OS**: macOS vs Linux → Different tools/paths
- **Hostname**: Work (`Work-MacBook-Pro.local`) vs Personal → Different settings

### Work Machine
- Higher resource limits
- Work-specific configurations
- Private session scripts

### Personal Machine
- Standard configurations
- Personal projects and tools

## Repository Structure

```
~/src/dot_files/                    # Chezmoi source directory
├── .chezmoi.toml.tmpl              # Environment detection
├── .chezmoiignore                  # Files excluded from deployment
├── README.md                       # This file
├── _archive/                       # Legacy configs (2014-2021)
├── docs/
│   ├── tmux.md                     # Tmux documentation
│   ├── bash.md                     # Bash documentation
│   ├── zsh.md                      # Zsh documentation
│   ├── git.md                      # Git documentation
│   └── vim.md                      # Vim documentation
├── dot_bash_profile.tmpl           # Bash login shell
├── dot_bashrc.tmpl                 # Bash interactive shell
├── dot_zprofile.tmpl               # Zsh login shell
├── dot_zshrc.tmpl                  # Zsh interactive shell
├── dot_shell_common.sh.tmpl        # Shared bash/zsh config
├── dot_gitconfig.tmpl              # Git configuration
├── dot_vimrc                        # Vim configuration
├── dot_tmux/
│   └── dot_tmux.conf.tmpl          # Tmux configuration
├── dot_xinitrc.tmpl                 # X11 session startup (Linux)
├── dot_Xresources.tmpl              # X11 resources (Linux)
├── dot_xinputrc                     # IBus input method (Linux)
├── dot_config/                      # Tool configurations
│   ├── bat/config                  # bat theme and settings
│   ├── lazygit/config.yml          # lazygit configuration
│   ├── gh/config.yml.tmpl          # GitHub CLI settings
│   ├── sesh/sesh.toml              # sesh session manager
│   ├── i3/config.tmpl              # i3 window manager (Linux)
│   ├── irssi/                      # IRC client (Linux)
│   │   ├── config.tmpl             # irssi configuration
│   │   ├── scripts/                # Perl scripts
│   │   └── README.md               # irssi documentation
│   └── conky/                       # System monitor (Linux)
│       ├── conky.conf.tmpl         # Desktop widget
│       ├── conky-status.conf.tmpl  # Status bar
│       └── README.md               # conky documentation
├── dot_local/share/xsessions/       # Desktop entries (Linux)
│   ├── dwm.desktop.tmpl            # dwm session
│   └── README.md                   # Session documentation
├── dot_local/bin/                   # Utility scripts (Linux)
│   ├── executable_i3lock-blur.tmpl # Screenshot-based screen lock
│   ├── executable_notify-listener.py.tmpl # Irssi desktop notifications
│   └── README.md                   # Script documentation
└── run_once_install-tools.sh.tmpl  # Tool installation script
```
## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Tmux Configuration](docs/tmux.md)
- [Git Configuration](docs/git.md)
- [Bash Configuration](docs/bash.md)
- [Zsh Configuration](docs/zsh.md)
- [Migration Notes](_archive/README.md)
- [Repository Guidelines](AGENTS.md)
