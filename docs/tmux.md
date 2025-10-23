# Tmux Configuration Documentation

Modern tmux 3.5a configuration with sesh session management, fzf integration, and popup-based workflows.

## Features

- **Modern tmux 3.5a+** - Uses latest features (extended-keys, set-clipboard, allow-passthrough)
- **True color support** - Full 24-bit color in terminal
- **Catppuccin Mocha theme** - Matches Vim theme for consistent look
- **Popup workflows** - Fuzzy finders, lazygit, session management
- **Smart session management** - sesh integration for project discovery
- **Plugin ecosystem** - TPM with catppuccin, resurrect, yank, vim-navigator

## Quick Start

```bash
# Start tmux
tmux

# Inside tmux: install plugins
Ctrl+a Shift+I

# Create new session for current directory
tn myproject

# Interactive session switcher
ts
```

## Key Bindings

### Prefix Key
- **Prefix**: `Ctrl+a` (screen-like, easier than default Ctrl+b)
- **Send prefix**: `Ctrl+a Ctrl+a` (to send Ctrl+a to underlying app)

### Sessions & Windows

| Key | Action |
|-----|--------|
| `Ctrl+a K` | Sesh session manager (large popup) |
| `Ctrl+a Ctrl+j` | Quick session switcher with fzf |
| `Ctrl+a Ctrl+w` | Window finder across all sessions |
| `Ctrl+a c` | New window (inherits current path) |
| `Ctrl+a Tab` | Last window |
| `Ctrl+a n/p` | Next/previous window |
| `Ctrl+a s` | Session tree (built-in) |
| `Ctrl+a x` | Kill pane |
| `Ctrl+a X` | Kill window |

### Panes

| Key | Action |
|-----|--------|
| `Ctrl+a \|` | Split horizontal (intuitive) |
| `Ctrl+a -` | Split vertical (intuitive) |
| `Ctrl+a h/j/k/l` | Navigate panes (vim-style) |
| `Ctrl+a H/J/K/L` | Resize panes |
| `Ctrl+a </>`| Swap panes |
| `Ctrl+a z` | Zoom pane (toggle fullscreen) |

### Modern Features (Popups)

| Key | Action |
|-----|--------|
| `Ctrl+a g` | Lazygit popup (95% size) |
| `Ctrl+a G` | Git status popup |
| `Ctrl+a Ctrl+f` | Zoxide directory jumper |
| `Ctrl+a N` | Quick notes (~/notes/tmux-scratch.md) |

### Copy Mode (Vi-style)

| Key | Action |
|-----|--------|
| `Ctrl+a Enter` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Rectangle selection |
| `y` | Yank (copy) - handled by tmux-yank plugin |
| `H/L` | Start/end of line |
| `Escape` | Cancel |
| `Ctrl+a p` | Paste buffer |
| `Ctrl+a b` | List buffers |
| `Ctrl+a P` | Choose buffer to paste |

### Configuration

| Key | Action |
|-----|--------|
| `Ctrl+a r` | Reload config |
| `Ctrl+a e` | Edit config in new window |

## Shell Integration

Add to `~/.zshrc` or `~/.bashrc`:

```bash
# Tmux already configured in dot_shell_common.sh.tmpl
# Functions available:
#   ts [session]  - Sesh connect (interactive or direct)
#   tn [name]     - New session for current directory
#   tk [session]  - Kill session with fzf
#   tw            - Switch sessions (from inside tmux)
#   twd           - Switch windows (from inside tmux)
#   tls           - List all sessions
#   tedit         - Edit tmux config
#   treload       - Reload tmux config
```

## Session Management with Sesh

Sesh discovers projects automatically and provides smart session management.

### Configuration

Edit `~/.config/sesh/sesh.toml`:

```toml
# Default session paths
[[session_path]]
path = "~/src"
depth = 2

[[session_path]]
path = "~/projects"
depth = 1

# Custom session scripts
[[scripts]]
directory = "~/.config/sesh/scripts"
```

### Creating Session Scripts

Create executable scripts in `~/.config/sesh/scripts/`:

```bash
#!/usr/bin/env bash
# ~/.config/sesh/scripts/project-dev.sh

set -euo pipefail

SESSION_NAME="${SESSION_NAME:-webapp}"
PROJECT_DIR="${PROJECT_DIR:-$HOME/projects/web-app}"

if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n "editor"

    tmux new-window -t "${SESSION_NAME}:2" -n "server" -c "$PROJECT_DIR"
    tmux send-keys -t "${SESSION_NAME}:2" "${START_SERVER_CMD:-# run: npm run dev}" C-m

    tmux new-window -t "${SESSION_NAME}:3" -n "tests" -c "$PROJECT_DIR"
    tmux send-keys -t "${SESSION_NAME}:3" "${TEST_CMD:-# run: npm test}" C-m

    tmux new-window -t "${SESSION_NAME}:4" -n "db" -c "$PROJECT_DIR"
    tmux send-keys -t "${SESSION_NAME}:4" "${DB_CMD:-# connect to your database client}" C-m

    tmux select-window -t "${SESSION_NAME}:1"
fi

tmux attach-session -t "$SESSION_NAME"
```

Make it executable:
```bash
chmod +x ~/.config/sesh/scripts/project-dev.sh
```

## Plugins

Managed via TPM (Tmux Plugin Manager).

### Installed Plugins

- **catppuccin/tmux** - Catppuccin Mocha theme (matches Vim)
- **tmux-resurrect** - Save/restore sessions (survives reboots)
- **tmux-continuum** - Auto-save sessions every 15 minutes
- **vim-tmux-navigator** - Seamless vim/tmux pane navigation
- **tmux-prefix-highlight** - Shows when prefix is active
- **tmux-yank** - Better clipboard handling (cross-platform)

### Plugin Commands

| Key | Action |
|-----|--------|
| `Ctrl+a Shift+I` | Install plugins |
| `Ctrl+a Shift+U` | Update plugins |
| `Ctrl+a Alt+u` | Uninstall unlisted plugins |
| `Ctrl+a Ctrl+s` | Save session (resurrect) |
| `Ctrl+a Ctrl+r` | Restore session (resurrect) |

## Theme

**Catppuccin Mocha** - Official theme plugin matching Vim configuration.

The theme uses the Catppuccin Mocha color palette:

```bash
# Catppuccin Mocha colors (applied automatically by plugin)
base="#1e1e2e"           # Deep blue-gray background
text="#cdd6f4"           # Light blue-gray text
crust="#11111b"          # Darker background
surface1="#45475a"       # Muted gray
blue="#89b4fa"           # Bright blue
mauve="#cba6f7"          # Purple accent
green="#a6e3a1"          # Green accent
yellow="#f9e2af"         # Yellow accent
red="#f38ba8"            # Red accent
```

### Theme Configuration

The Catppuccin theme is configured in `~/.tmux/.tmux.conf`:

```bash
# Set flavor to match Vim
set -g @catppuccin_flavour 'mocha'

# Customize status modules (right side)
set -g @catppuccin_status_modules_right "session host date_time"

# Date/time format
set -g @catppuccin_date_time_text "%H:%M %d %b"
```

Available flavors: `mocha`, `macchiato`, `frappe`, `latte` (change to match your Vim theme).

### Customization

Edit `~/.tmux/.tmux.conf` to modify:
- Status modules: `set -g @catppuccin_status_modules_right "..."`
- Window separators: `set -g @catppuccin_window_left_separator "..."`
- Date/time format: `set -g @catppuccin_date_time_text "..."`

See [Catppuccin tmux documentation](https://github.com/catppuccin/tmux) for all options.

## Performance Settings

```bash
set -s escape-time 10          # Fast escape (10ms)
set -g history-limit 50000     # 50k lines history (work), 10k (personal)
set -sg repeat-time 400        # Repeat timeout
set -s focus-events on         # Application focus events
```

## Troubleshooting

### Colors Look Wrong

Check terminal support:
```bash
echo $COLORTERM  # Should show "truecolor"
echo $TERM       # In tmux should be "tmux-256color"
```

Terminal settings:
- iTerm2: Preferences → Profiles → Terminal → Report Terminal Type: `xterm-256color`
- Enable "Report terminal with 256 colors"

### Plugins Not Working

TPM is automatically installed by the provisioning script. If missing:

```bash
# Re-run provisioning (recommended)
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply

# Or install TPM manually
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins (inside tmux)
Ctrl+a Shift+I
```

### Sesh Not Finding Projects

Check configuration:
```bash
cat ~/.config/sesh/sesh.toml
```

Add project directories:
```toml
[[session_path]]
path = "/path/to/your/projects"
depth = 2
```

### Clipboard Not Working

macOS uses pbcopy/pbpaste automatically via tmux-yank.

Linux may need xclip or xsel:
```bash
sudo apt-get install xclip
# or
sudo apt-get install xsel
```

### Session Not Persisting

Check continuum status:
```bash
# Inside tmux
tmux show-environment -g
# Should see: TMUX_CONTINUUM_STATUS=...
```

Continuum auto-saves every 15 minutes. To force save:
```bash
Ctrl+a Ctrl+s
```

## Advanced Configuration

### Change Prefix Key

Edit `~/.tmux/.tmux.conf`:
```bash
unbind C-a
set -g prefix C-b  # Or any key you prefer
bind C-b send-prefix
```

### Add Custom Popup

```bash
# Add to ~/.tmux/.tmux.conf
bind C-t display-popup -E -w 80% -h 80% -d "#{pane_current_path}" \
  "your-command-here"
```

### Custom Status Bar

The Catppuccin plugin manages the status bar. To customize modules:

```bash
# Edit ~/.tmux/.tmux.conf
set -g @catppuccin_status_modules_right "session host date_time"

# Available modules: application, session, user, host, directory, date_time
# See: https://github.com/catppuccin/tmux#status-modules
```

## Resources

- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [Tmux Wiki](https://github.com/tmux/tmux/wiki)
- [Sesh Documentation](https://github.com/joshmedeski/sesh)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)
- Config file: `~/.tmux/.tmux.conf`
- Cheatsheet: `~/src/dot_files/docs/tmux-cheatsheet.md`
