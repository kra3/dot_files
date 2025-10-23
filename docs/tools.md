# Shared Tools Documentation

Modern CLI tools integrated across bash and zsh shells.

## Overview

These tools are configured in `.shell_common.sh` and work identically in both bash and zsh.

## Tool Categories

- **Search & Navigation** - fzf, zoxide, ripgrep
- **File Operations** - eza, bat
- **Version Management** - pyenv, jenv, nvm
- **Environment** - direnv

---

## Search & Navigation

### fzf - Fuzzy Finder

**Purpose:** Interactive fuzzy finder for files, commands, history, etc.

**Installation:**
```bash
brew install fzf
```

**Key Bindings** (automatic):
- `Ctrl+R` - Fuzzy command history search
- `Ctrl+T` - Fuzzy file finder
- `Alt+C` - Fuzzy directory finder

**Configuration:**
```bash
# Use ripgrep for file search
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

**Usage Examples:**
```bash
# Search command history
Ctrl+R
# Type: git
# Fuzzy matches: git status, git commit, git push

# Find file
Ctrl+T
# Type: readme
# Fuzzy matches: README.md, readme.txt

# Change directory
Alt+C
# Type: dot
# Fuzzy matches: dot_files, dotnet, etc.
```

**Custom Functions:**
```bash
# Note-taking with fzf (defined in .shell_common.sh)
n
# Opens fuzzy finder for notes in ~/.notes/
```

**Pro Tips:**
- Type space-separated terms to AND them
- Use `!` to exclude (e.g., `!test` excludes files with "test")
- Use `'` for exact match (e.g., `'readme.md`)
- Use `^` for prefix (e.g., `^read`)
- Use `$` for suffix (e.g., `.md$`)

---

### zoxide - Smart cd

**Purpose:** Frecency-based directory jumper (tracks frequency + recency).

**Installation:**
```bash
brew install zoxide
```

**Initialization:**
```bash
# In bash
eval "$(zoxide init bash)"

# In zsh
eval "$(zoxide init zsh)"
```

**Commands:**
```bash
# Jump to directory (by frecency)
z src           # Jumps to ~/src
z dot           # Jumps to ~/src/dot_files
z docs          # Jumps to most-used 'docs' directory

# Interactive mode with fzf
zi

# Add current directory to database
zoxide add .

# Query database
zoxide query src

# Remove directory from database
zoxide remove ~/old/path
```

**How It Works:**
- Tracks every `cd` command
- Ranks directories by **frecency** = frequency × recency
- `z` jumps to highest-ranked match

**Examples:**
```bash
# After using these directories
cd ~/src/dot_files/docs
cd ~/src/project/docs
cd ~/src/dot_files/docs  # Used more recently

# z docs → ~/src/dot_files/docs (higher frecency)
z project    # → ~/src/project
z dot        # → ~/src/dot_files
```

---

### ripgrep (rg) - Fast Search

**Purpose:** Extremely fast recursive search tool (replacement for grep/ag/ack).

**Installation:**
```bash
brew install ripgrep
```

**Aliases:**
```bash
# No longer aliased - use 'rg' directly
# This avoids breaking scripts that expect POSIX grep behavior
```

**Note:** We don't alias `grep='rg'` because ripgrep and grep have incompatible flags. Use `rg` directly when you want ripgrep features.

**Basic Usage:**
```bash
# Search for pattern
rg "function"

# Case-insensitive
rg -i "TODO"

# Search specific file types
rg -t js "console.log"
rg -t py "import"

# Show context (3 lines before/after)
rg -C 3 "error"
```

**Advanced:**
```bash
# Search hidden files
rg --hidden "config"

# Follow symlinks
rg --follow "pattern"

# Exclude directories
rg --glob "!node_modules" "function"

# Multiple patterns
rg -e "TODO" -e "FIXME"

# Count matches
rg -c "function"

# List files with matches
rg -l "import"
```

**Advantages over grep:**
- 10-100x faster
- Respects `.gitignore` by default
- Automatic file type detection
- Colored output by default
- Searches compressed files

---

## File Operations

### eza - Modern ls

**Purpose:** Modern replacement for `ls` with git integration and colors.

**Installation:**
```bash
brew install eza
```

**Aliases:**
```bash
alias ls='eza'
alias l='eza -F'
alias ll='eza -lhF --git'
alias la='eza -lhaF --git'
alias tree='eza --tree'
alias lsd='eza -lD'  # List only directories
```

**Features:**
- Git status integration (shows modified/staged files)
- Color-coded file types
- Icons support (with Nerd Fonts)
- Tree view
- Sorting by size, date, extension

**Usage:**
```bash
# Basic listing with git status
ll
# Shows: modified (M), staged (✓), untracked (?)

# Tree view (depth 2)
eza --tree --level=2

# Sort by size
eza -lhS

# Sort by date (newest first)
eza -lht

# Group directories first
eza -lh --group-directories-first
```

**Comparison with ls:**
- `ls -la` → `eza -lhaF --git`
- `tree` → `eza --tree`
- Color-coded by default
- Git status built-in

---

### bat - Modern cat

**Purpose:** `cat` clone with syntax highlighting and git integration.

**Installation:**
```bash
brew install bat
```

**Aliases:**
```bash
alias cat='bat --paging=never'
alias less='bat --paging=always'
```

**Features:**
- Syntax highlighting for 200+ languages
- Git diff integration
- Line numbers
- Pager integration

**Usage:**
```bash
# View file with syntax highlighting
bat script.sh

# View with line numbers
bat -n script.sh

# Show git changes (side-by-side)
bat --diff script.sh

# Plain output (no decorations)
bat -p script.sh

# Set theme
bat --theme="Monokai Extended" file.js
```

**Integration with other tools:**
```bash
# Use as MANPAGER
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# fzf preview
fzf --preview 'bat --color=always {}'
```

---

## Version Management

### pyenv - Python Version Manager

**Purpose:** Manage multiple Python versions.

**Installation:**
```bash
brew install pyenv
```

**Initialization** (two-stage):
```bash
# 1. In .bash_profile / .zprofile (login shell)
eval "$(pyenv init --path)"

# 2. In .shell_common.sh (interactive shell)
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"  # bash only
```

**Usage:**
```bash
# List available versions
pyenv install --list

# Install Python version
pyenv install 3.11.7

# Set global Python version
pyenv global 3.11.7

# Set local version (per-directory)
pyenv local 3.10.5

# Create virtualenv
pyenv virtualenv 3.11.7 myproject

# Activate virtualenv
pyenv activate myproject

# Deactivate
pyenv deactivate

# List versions
pyenv versions
```

**How It Works:**
- Creates `.python-version` file in directory
- Automatically switches versions when entering directory
- Shims in PATH intercept python commands

---

### jenv - Java Version Manager

**Purpose:** Manage multiple Java (JDK) versions.

**Installation:**
```bash
brew install jenv
```

**Initialization:**
```bash
eval "$(jenv init -)"
```

**Usage:**
```bash
# Add Java version
jenv add /Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home

# List versions
jenv versions

# Set global version
jenv global 17

# Set local version
jenv local 11

# Set shell version (current session)
jenv shell 8

# Enable plugins
jenv enable-plugin maven
jenv enable-plugin gradle
```

---

### nvm - Node Version Manager (Lazy-Loaded)

**Purpose:** Manage multiple Node.js versions with lazy-loading for performance.

**Installation:**
```bash
brew install nvm
```

**Lazy-Loading Configuration:**
```bash
# Creates wrapper functions that load nvm only when first called
nvm() {
    unset -f nvm node npm npx
    [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && source "$BREW_PREFIX/opt/nvm/nvm.sh"
    nvm "$@"
}

# Similar wrappers for node, npm, npx
```

**Performance:**
- Normal loading: ~500ms startup overhead
- Lazy-loading: ~0ms until first use

**Usage:**
```bash
# Install Node version (triggers nvm load)
nvm install 20

# Use specific version
nvm use 20

# Set default version
nvm alias default 20

# List versions
nvm ls

# Install LTS
nvm install --lts

# Use system Node
nvm use system
```

**.nvmrc file:**
```bash
# Create .nvmrc in project
echo "20" > .nvmrc

# Auto-switch when entering directory
nvm use
```

---

## Environment Management

### direnv - Directory Environments

**Purpose:** Automatically load/unload environment variables based on directory.

**Installation:**
```bash
brew install direnv
```

**Initialization:**
```bash
# In bash
eval "$(direnv hook bash)"

# In zsh
eval "$(direnv hook zsh)"
```

**Usage:**
```bash
# Create .envrc in project directory
cat > .envrc << 'EOF'
export DATABASE_URL="postgres://localhost/mydb"
export API_KEY="dev-key-12345"
layout python python3.11
EOF

# Allow direnv to load it
direnv allow

# Variables are loaded when entering directory
cd myproject
# DATABASE_URL and API_KEY are now set

# Unloaded when leaving
cd ..
# Variables are unset
```

**Layouts:**
```bash
# Python virtualenv
layout python python3.11

# Node (use .nvmrc)
layout node

# Ruby (use .ruby-version)
layout ruby
```

**Security:**
- Requires explicit `direnv allow` before loading
- Tracks changes to .envrc
- Re-prompts if .envrc is modified

---

## Tmux Integration

All these tools integrate with tmux. See [tmux.md](tmux.md) for:
- `Ctrl+a K` - Sesh session manager (uses fzf)
- `Ctrl+a Ctrl+f` - Zoxide popup (jump to directory)
- `Ctrl+a g` - Lazygit popup
- `ts`, `tn`, `tk`, `tw` - Tmux functions using fzf

---

## Configuration Files

### .shell_common.sh

All tools are configured in this shared file:

```bash
# Tool initializations
eval "$(zoxide init bash)"  # or zsh
eval "$(pyenv init -)"
eval "$(jenv init -)"
eval "$(direnv hook bash)"  # or zsh

# fzf integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias ls='eza'
alias cat='bat --paging=never'

# Note: grep is NOT aliased to rg to avoid breaking scripts
# Use 'rg' directly for better performance

# Environment variables
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export EDITOR="vim"
export PAGER="less"
export LESS="-R -F -X -i"

# LS_COLORS with vivid (modern, theme-based)
if command -v vivid &> /dev/null; then
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
fi
```

---

## Performance Tips

1. **nvm lazy-loading** - Already configured (saves 500ms startup)
2. **zoxide** - Very fast (written in Rust)
3. **fzf** - Fast even with large datasets
4. **ripgrep** - 10-100x faster than grep
5. **eza/bat** - Minimal overhead

---

## Troubleshooting

### fzf Not Working

```bash
# Check if installed
which fzf

# Re-install keybindings
$(brew --prefix)/opt/fzf/install
```

### zoxide Not Jumping

```bash
# Build up database first (cd to directories)
cd ~/src
cd ~/projects
cd ~/Documents

# Then z will work
z src
```

### ripgrep Too Fast (Missing Results)

```bash
# Include hidden files
rg --hidden "pattern"

# Include .gitignore files
rg --no-ignore "pattern"

# Include everything
rg --no-ignore --hidden "pattern"
```

### pyenv/jenv Not Switching

```bash
# Check PATH
echo $PATH | grep pyenv

# Re-initialize
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Check shims
pyenv which python
```

### direnv Not Loading

```bash
# Check hook is installed
type direnv

# Allow .envrc
direnv allow

# Check status
direnv status
```

---

## Resources

- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [pyenv](https://github.com/pyenv/pyenv)
- [jenv](https://github.com/jenv/jenv)
- [nvm](https://github.com/nvm-sh/nvm)
- [direnv](https://github.com/direnv/direnv)
- Configuration: `~/.shell_common.sh`
