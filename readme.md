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

- ✅ **Tmux** - Modern tmux 3.5a with sesh session management, popups, fzf ([docs](docs/tmux.md))
- ✅ **Git** - Delta, git-absorb, difftastic, 50+ aliases ([docs](docs/git.md))
- ✅ **Bash** - Modern bash 5.3+ with enhanced history, completions ([docs](docs/bash.md))
- ✅ **Zsh** - Powerlevel10k, optimized completions, instant prompt ([docs](docs/zsh.md))
- 🔄 **Vim** - Coming soon

### Tools Installed (31 Total)

**Core:**
- `git`, `gh` - Version control and GitHub CLI
- `vim` - Text editor
- `curl`, `jq` - Data transfer and JSON processing
- `awscli` - AWS command line interface
- `docker`, `docker-compose` - Container platform

**Terminal Multiplexing:**
- `tmux` - Terminal multiplexer
- `sesh` - Smart session manager

**Navigation & Search:**
- `fzf` - Fuzzy finder
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
- `direnv` - Directory-specific environments
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
    helper = !/opt/homebrew/bin/gh auth git-credential

[credential "https://github.company.com"]
    helper =
    helper = !/opt/homebrew/bin/gh auth git-credential

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
│   └── tmux-cheatsheet.md          # Quick reference
├── scripts/                        # Helper scripts
├── dot_bash_profile.tmpl           # Bash login shell
├── dot_bashrc.tmpl                 # Bash interactive shell
├── dot_zprofile.tmpl               # Zsh login shell
├── dot_zshrc.tmpl                  # Zsh interactive shell
├── dot_shell_common.sh.tmpl        # Shared bash/zsh config
├── dot_gitconfig.tmpl              # Git configuration
├── dot_tmux/
│   └── dot_tmux.conf.tmpl          # Tmux configuration
└── run_once_install-tools.sh.tmpl  # Tool installation script
```

## Migration Status

This repository has been modernized from a manual symlink-based setup to chezmoi.

**Completed**:
- ✅ Chezmoi initialization and environment detection
- ✅ Tmux modernization (3.5a with Vuesion theme, popups, sesh)
- ✅ Git modernization (delta, git-absorb, difftastic, 50+ aliases)
- ✅ Bash modernization (5.3+ with enhanced history, lazy-loading)
- ✅ Zsh modernization (5.9+ with Powerlevel10k, performance optimization)
- ✅ Comprehensive provisioning script (31 tools)
- ✅ Complete documentation (tmux, git, bash, zsh)
- ✅ Work/personal separation via local config files

**Planned**:
- 📋 Vim cleanup and modernization
- 📋 Neovim migration (optional)

## History

- **2014-2021**: Manual symlink-based dotfiles
- **October 2025**: Migrated to chezmoi with modern tooling
- **Tag `v1-legacy`**: Snapshot of pre-chezmoi setup

## Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Tmux Configuration](docs/tmux.md)
- [Git Configuration](docs/git.md)
- [Bash Configuration](docs/bash.md)
- [Zsh Configuration](docs/zsh.md)
- [Migration Notes](_archive/README.md)

---

**Last Updated**: October 2025
**Chezmoi Version**: 2.66.1+
**Status**: Fully modernized and documented
