# Tmux Configuration Documentation

Modern tmux 3.5a configuration with sesh session management, fzf integration, and popup-based workflows.

## Features

- **Modern tmux 3.5a+** - Uses latest features (extended-keys, set-clipboard, allow-passthrough)
- **True color support** - Full 24-bit color in terminal
- **Catppuccin Mocha theme** - Manually installed (recommended over TPM)
- **Popup workflows** - Fuzzy finders, lazygit, session management
- **Smart session management** - sesh integration for project discovery
- **Plugin ecosystem** - TPM with catppuccin, resurrect, yank, pain-control

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

### Session Management

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a S` | **Sesh session manager** | Multi-mode fuzzy finder (see below) |
| `Ctrl+a s` | Session tree | Built-in hierarchical view |
| `Ctrl+a A` | **Last session** | Switch to previously active session |
| `Ctrl+a (` | Previous session | Sequential navigation |
| `Ctrl+a )` | Next session | Sequential navigation |

#### Sesh Manager Modes (Ctrl+a S)

Inside sesh, press these keys to switch modes:

| Key | Mode | Description |
|-----|------|-------------|
| `Ctrl+a` | All | Show all sessions (tmux, configs, zoxide, scripts) |
| `Ctrl+t` | **Tmux sessions** | Show only running tmux sessions |
| `Ctrl+g` | Configs | Show config directories (~/.config/*) |
| `Ctrl+x` | **Zoxide directories** | Show frequently visited directories |
| `Ctrl+f` | Find | Browse directories (fd, depth 3) |
| `Ctrl+d` | Kill | Delete selected tmux session |

**Note:** Use `Ctrl+t` for session switching and `Ctrl+x` for directory navigation - these replace the old dedicated popups.

### Window Management

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a c` | New window | Inherits current directory |
| `Ctrl+a 0-9` | Jump to window | Direct access |
| `Ctrl+a n` | Next window | Sequential |
| `Ctrl+a p` | Previous window | Sequential |
| `Ctrl+a a` | **Last window** | Within current session (tmux-sensible) |
| `Ctrl+a w` | List windows | Interactive chooser |
| `Ctrl+a Ctrl+w` | Window finder | Across all sessions (fzf) |
| `Ctrl+a ,` | Rename window | Interactive prompt |
| `Ctrl+a <` | **Move window left** | Shift position in list (repeatable) |
| `Ctrl+a >` | **Move window right** | Shift position in list (repeatable) |
| `Ctrl+a X` | Kill window | No confirmation |

### Pane Navigation

| Key | Action | Source |
|-----|--------|--------|
| `Ctrl+a h` | Select pane **left** | tmux-pain-control |
| `Ctrl+a j` | Select pane **down** | tmux-pain-control |
| `Ctrl+a k` | Select pane **up** | tmux-pain-control |
| `Ctrl+a l` | Select pane **right** | tmux-pain-control |
| `Ctrl+a Ctrl+h/j/k/l` | Alternative navigation | Hold Ctrl for repeat |

### Pane Splitting

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a \|` | Split vertically | Creates left/right panes, same path |
| `Ctrl+a -` | Split horizontally | Creates top/bottom panes, same path |
| `Ctrl+a \` | Split vertically (full width) | Extends full window width |
| `Ctrl+a _` | Split horizontally (full height) | Extends full window height |

### Pane Resizing

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a H` (Shift+h) | Resize **left** | 5 cells, repeatable |
| `Ctrl+a J` (Shift+j) | Resize **down** | 5 cells, repeatable |
| `Ctrl+a K` (Shift+k) | Resize **up** | 5 cells, repeatable |
| `Ctrl+a L` (Shift+l) | Resize **right** | 5 cells, repeatable |

### Pane Manipulation

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a {` | **Swap with previous pane** | Rotates pane positions backward |
| `Ctrl+a }` | **Swap with next pane** | Rotates pane positions forward |
| `Ctrl+a !` | **Break pane to window** | Traditional tmux default |
| `Ctrl+a T` | **Break pane to window** | Easier alternative (same as !) |
| `Ctrl+a m` | **Merge pane (horizontal)** | Choose window, merge side-by-side |
| `Ctrl+a v` | **Merge pane (vertical)** | Choose window, merge top/bottom |
| `Ctrl+a z` | **Zoom pane** | Toggle fullscreen |
| `Ctrl+a x` | Kill pane | No confirmation |
| `Ctrl+a Ctrl+o` | Rotate panes | Cycle all panes forward |

### Modern Features (Popups)

| Key | Action | Notes |
|-----|--------|-------|
| `Ctrl+a g` | Lazygit | 95% screen size |
| `Ctrl+a G` | Git status | Compact popup |
| `Ctrl+a D` | **GitHub Dashboard** | gh-dash - PRs, issues, notifications |
| `Ctrl+a Ctrl+w` | **Window finder** | Find windows across all sessions |
| `Ctrl+a N` | Quick notes | ~/notes/tmux-scratch.md |

### Copy Mode (Vi-style)

| Key | Action |
|-----|--------|
| `Ctrl+a Enter` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Rectangle selection |
| `y` | Yank (copy) - handled by tmux-yank |
| `H` | Jump to start of line |
| `L` | Jump to end of line |
| `Escape` | Cancel |
| `Ctrl+a p` | Paste buffer |
| `Ctrl+a b` | List buffers |
| `Ctrl+a P` | Choose buffer to paste |

### Configuration

| Key | Action |
|-----|--------|
| `Ctrl+a e` | Edit config in new window |
| `Ctrl+a ?` | List all key bindings |
| `Ctrl+a :` | Command prompt |

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

### Interactive Mode (Ctrl+a S)

The sesh session manager has multiple modes accessible via keyboard shortcuts:

| Key | Mode | Description |
|-----|------|-------------|
| `Ctrl+a` | All | Show all sessions (tmux, configs, zoxide, scripts) |
| `Ctrl+t` | Tmux | Show only tmux sessions |
| `Ctrl+g` | Configs | Show config directories (~/.config/*) |
| `Ctrl+x` | Zoxide | Show frequently visited directories (zoxide) |
| `Ctrl+f` | Find | Browse directories (fd, depth 3, excludes hidden) |
| `Ctrl+d` | Kill | Delete selected tmux session |

**Usage:**
1. Press `Ctrl+a S` to open sesh
2. Use `Ctrl+<key>` to switch modes
3. Type to filter, arrow keys to navigate
4. Press `Enter` to connect to session

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

- **tmux-sensible** - Sensible defaults (base-index 1, focus-events, etc.)
- **tmux-pain-control** - Standard pane bindings (h/j/k/l navigation, H/J/K/L resizing, |/- splitting)
- **catppuccin/tmux** - Catppuccin Mocha theme (manually installed, recommended)
- **tmux-resurrect** - Save/restore sessions (survives reboots)
- **tmux-continuum** - Auto-save sessions every 15 minutes
- **tmux-battery** - Battery status in status bar
- **tmux-yank** - Better clipboard handling (cross-platform)
- **tmux-open** - Open highlighted text/files

### Plugin Commands

| Key | Action |
|-----|--------|
| `Ctrl+a Shift+I` | Install plugins |
| `Ctrl+a Shift+U` | Update plugins |
| `Ctrl+a Alt+u` | Uninstall unlisted plugins |
| `Ctrl+a Ctrl+s` | Save session (resurrect) |
| `Ctrl+a Ctrl+r` | Restore session (resurrect) |

## Theme

**Catppuccin Mocha** - Manually installed theme (recommended over TPM).

The theme uses the Catppuccin Mocha color palette:

```bash
# Catppuccin Mocha colors (applied automatically)
base="#1e1e2e"           # Deep blue-gray background
text="#cdd6f4"           # Light blue-gray text
crust="#11111b"          # Darker background
surface1="#45475a"       # Muted gray
blue="#89b4fa"           # Bright blue
mauve="#cba6f7"          # Purple accent
lavender="#b4befe"       # Lavender (battery icon)
green="#a6e3a1"          # Green accent
yellow="#f9e2af"         # Yellow accent
red="#f38ba8"            # Red accent
```

### Status Bar Configuration

**Left side:** Session | Application | Directory
**Right side:** Battery | Date/Time

Theme configured in `~/.tmux.conf`:

```bash
# Set flavor
set -g @catppuccin_flavor 'mocha'

# Window style
set -g @catppuccin_window_status_style "rounded"

# Date/time format
set -g @catppuccin_date_time_text "%d-%m-%Y 󰅐 %H:%M"
set -g @catppuccin_date_time_icon "󰭦"

# Status line (configured after TPM loads)
set -g status-left "#{E:@catppuccin_status_session}"
set -ag status-left "#{E:@catppuccin_status_application}"
set -ag status-left "#{E:@catppuccin_status_directory}"

set -g status-right "#{E:@catppuccin_status_battery}"
set -ag status-right "#{E:@catppuccin_status_date_time}"
```

Available flavors: `mocha`, `macchiato`, `frappe`, `latte`

### Customization

See [Catppuccin tmux documentation](https://github.com/catppuccin/tmux) for all options.

## Performance Settings

```bash
set -s escape-time 10          # Fast escape (10ms)
set -g history-limit 50000     # 50k lines history
set -sg repeat-time 400        # Repeat timeout
set -s focus-events on         # Application focus events
set -s extended-keys on        # Better key binding support
set -s set-clipboard on        # External clipboard access
set -g allow-passthrough on    # Modern terminal features
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

### Catppuccin Not Loading

The theme is manually installed (recommended). If missing:

```bash
# Re-run provisioning
chezmoi apply

# Or install manually
mkdir -p ~/.tmux/plugins
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin
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

Edit `~/.tmux.conf`:
```bash
unbind C-a
set -g prefix C-b  # Or any key you prefer
bind C-b send-prefix
```

### Add Custom Popup

```bash
# Add to ~/.tmux.conf
bind C-t display-popup -E -w 80% -h 80% -d "#{pane_current_path}" \
  "your-command-here"
```

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│ PREFIX: Ctrl+a                                          │
├─────────────────────────────────────────────────────────┤
│ SESSIONS (use Sesh manager: Ctrl+a S)                   │
│  S        Sesh manager (multi-mode)                     │
│    Ctrl+t   → Tmux sessions (replaces old Ctrl+j)       │
│    Ctrl+x   → Zoxide directories (replaces old Ctrl+f)  │
│    Ctrl+a   → All (projects, configs, scripts)          │
│  A        Last session                                  │
│  (/)      Previous/Next session                         │
│  s        Session tree (native)                         │
├─────────────────────────────────────────────────────────┤
│ WINDOWS                                                 │
│  c        Create window                                 │
│  a        Last window                                   │
│  0-9      Jump to window                                │
│  </>      Move window left/right                        │
│  Ctrl+w   Find window across sessions                   │
│  X        Kill window                                   │
├─────────────────────────────────────────────────────────┤
│ PANES                                                   │
│  |/-      Split vertical/horizontal                     │
│  h/j/k/l  Navigate (vim-style)                          │
│  H/J/K/L  Resize (Shift, 5 cells)                       │
│  {/}      Swap with prev/next                           │
│  !  or T  Break to new window                           │
│  m        Merge horizontal from window                  │
│  v        Merge vertical from window                    │
│  z        Zoom (fullscreen toggle)                      │
│  x        Kill pane                                     │
├─────────────────────────────────────────────────────────┤
│ SPECIAL                                                 │
│  g        Lazygit popup                                 │
│  D        GitHub Dashboard (gh-dash)                    │
│  N        Quick notes                                   │
│  Enter    Copy mode                                     │
│  e        Edit config                                   │
└─────────────────────────────────────────────────────────┘
```

## Resources

- [Tmux Manual](https://man.openbsd.org/tmux.1)
- [Tmux Wiki](https://github.com/tmux/tmux/wiki)
- [Sesh Documentation](https://github.com/joshmedeski/sesh)
- [Catppuccin Tmux](https://github.com/catppuccin/tmux)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)
- Config file: `~/.tmux.conf`
