# Readline Configuration

Modern GNU Readline configuration with vi mode, advanced completion, and security features.

> **Config Location**: `~/.inputrc` (managed via chezmoi as `dot_inputrc.tmpl`)
> **Requires**: readline 7.0+ (bash 5.0+) for modern features

## Overview

Readline is a library used by **hundreds** of command-line programs for line editing, history, and completion. Configuring `~/.inputrc` affects **all** readline-enabled programs simultaneously.

### Philosophy

- **Vi mode everywhere** - Consistent vim keybindings across all CLI tools
- **Smart completion** - Case-insensitive, colorized, instant feedback
- **Security first** - Bracketed paste prevents accidental command execution
- **Power user ready** - 50+ keybindings, visual mode indicators, fast escape

## Programs Affected

This configuration applies to **all** programs using libreadline:

### Core Development Tools
- **bash** - Interactive shell
- **python/python3** - Python REPL
- **node** - Node.js REPL
- **irb** - Ruby REPL

### Database Clients
- **psql** - PostgreSQL
- **mysql** - MySQL/MariaDB
- **sqlite3** - SQLite
- **redis-cli** - Redis

### System Tools
- **gdb** - GNU Debugger
- **bc** - Calculator
- **ftp/sftp** - File transfer
- **gnuplot** - Plotting tool

### And Many More
Any program linked against libreadline inherits this configuration.

## Key Features

### Editing Mode: Vi

This configuration uses **vi mode** with enhancements:

✅ **Vi insert mode** - Full set of 30+ keybindings
✅ **Vi command mode** - All traditional vi navigation
✅ **Fast escape** - Type `jj` to exit insert mode (faster than ESC)
✅ **Visual feedback** - Cursor shape changes (bar in insert, block in command)
✅ **Emacs shortcuts** - Ctrl-a/e/w/k/u work in insert mode
✅ **History search** - Works in both insert and command modes

### Security Features

✅ **Bracketed paste mode** - Prevents pasted commands from executing immediately
✅ **Safe defaults** - No accidental command execution from clipboard

### Completion Features

✅ **Case-insensitive** - Type lowercase, matches any case
✅ **Instant display** - No double-Tab needed
✅ **Colorized** - Uses LS_COLORS for visual feedback
✅ **File type indicators** - `@` for symlinks, `*` for executables, `/` for directories
✅ **Smart prefix** - Common prefix highlighted in color

## Vi Mode Quick Reference

### Insert Mode (Default)

You spend most of your time here, typing commands.

#### Escape to Command Mode
```
jj              Fast escape (type quickly)
ESC             Traditional escape
```

#### Navigation (Emacs-style)
```
Ctrl-a          Beginning of line
Ctrl-e          End of line
Ctrl-Left       Previous word
Ctrl-Right      Next word
Home            Beginning of line
End             End of line
```

#### Editing
```
Ctrl-w          Delete word backward
Ctrl-k          Delete to end of line
Ctrl-u          Delete to beginning of line
Ctrl-y          Paste (yank) killed text
Ctrl-d          Delete character under cursor
```

#### History
```
Up arrow        Search history by prefix
Down arrow      Search history forward
Ctrl-p          Previous history
Ctrl-n          Next history
Ctrl-r          Reverse incremental search
Ctrl-s          Forward incremental search
```

#### Completion
```
Tab             Complete
Shift-Tab       Cycle backward through completions
```

#### Other
```
Ctrl-l          Clear screen
```

### Command Mode

Enter with `ESC` or `jj` from insert mode. Cursor becomes block.

#### Enter Insert Mode
```
i               Insert at cursor
I               Insert at beginning of line
a               Append after cursor
A               Append at end of line
```

#### Navigation
```
h               Left
l               Right
w               Word forward
b               Word backward
0               Beginning of line
^               First non-whitespace character
$               End of line
```

#### History
```
k               Previous history
j               Next history
/               Search forward in history
?               Search backward in history
n               Next search result
N               Previous search result
Up arrow        Search history by prefix
Down arrow      Search history forward
Ctrl-r          Reverse incremental search
```

#### Editing
```
x               Delete character under cursor
X               Delete character before cursor
dw              Delete word forward
db              Delete word backward
dd              Delete entire line
D               Delete to end of line
cc              Change entire line
C               Change to end of line
ciw             Change inner word
v               Edit command in $EDITOR (opens vim!)
```

#### Other
```
Ctrl-l          Clear screen
Ctrl-a          Beginning of line (Emacs compat)
Ctrl-e          End of line (Emacs compat)
```

## Configuration Details

### Completion Behavior

```bash
set completion-ignore-case on           # Case-insensitive matching
set completion-map-case on              # Treat - and _ as equivalent
set show-all-if-ambiguous on            # Show all matches on first Tab
set show-all-if-unmodified on           # Show matches without bell
set colored-stats on                    # Colorize completions
set colored-completion-prefix on        # Color common prefix
set menu-complete-display-prefix on     # Show prefix when cycling
set mark-symlinked-directories on       # Add / to symlinked dirs
set visible-stats on                    # Show file type indicators
set mark-directories on                 # Add / to directories
```

**Example:**
```bash
# Before
$ cd ~/doc<Tab><Tab>
Documents/  Downloads/

# After (with show-all-if-ambiguous)
$ cd ~/doc<Tab>
Documents/  Downloads/
# ^ Shown immediately, no double-Tab
```

### Modern Readline 7.0+ Features

```bash
set enable-bracketed-paste on           # Security: prevent paste execution
set revert-all-at-newline on            # Fresh line for each command
set show-mode-in-prompt on              # Visual mode indicator
set vi-ins-mode-string "\1\e[6 q\2"    # Vertical bar cursor (insert)
set vi-cmd-mode-string "\1\e[2 q\2"    # Block cursor (command)
set skip-completed-text on              # Smart cursor positioning
set expand-tilde on                     # Expand ~/ to full path
```

### Bell & Display

```bash
set bell-style none                     # Silent operation
set page-completions on                 # Page if too many matches
set completion-query-items 100          # Ask before showing >100
set echo-control-characters off         # Don't show ^C, etc.
```

## History Search

One of the most powerful readline features.

### Prefix Search

Type a partial command, then press Up/Down to search history for matching commands.

```bash
# Type partial command
$ git ch<Up>
# Shows: git checkout main

# Empty line
$ <Up>
# Shows: previous command (normal behavior)
```

### Incremental Search

Search through entire history:

```bash
# Press Ctrl-r
(reverse-i-search)`':
# Type search term
(reverse-i-search)`check': git checkout main
# Press Ctrl-r again to find next match
# Press Enter to use command, Ctrl-g to cancel
```

### Search in Both Modes

History search works in **both** vi insert and command modes:

- **Insert mode**: Up/Down arrows, Ctrl-p/n, Ctrl-r/s
- **Command mode**: k/j, /, ?, Up/Down arrows, Ctrl-r

## Visual Mode Indicators

When `show-mode-in-prompt` is enabled, your cursor changes shape to indicate mode:

| Mode | Cursor | Appearance |
|------|--------|------------|
| **Insert** | Vertical bar (I-beam) | `\|` |
| **Command** | Block | `█` |

This provides instant visual feedback about which mode you're in.

## Fast Escape with `jj`

The most popular vi-mode enhancement. Instead of reaching for ESC:

```bash
# In insert mode, type "jj" quickly
$ git status jj
              ^^
# Instantly enters command mode
```

**Why it's better than ESC:**
- ✅ Fingers stay on home row
- ✅ 3x faster than reaching for ESC
- ✅ Works even if terminal has ESC lag

## Bracketed Paste Mode

**Security feature** - prevents pasted text from executing immediately.

### Without Bracketed Paste (UNSAFE)
```bash
# Copy this from a malicious website:
$ ls -la
$ rm -rf /
# Paste → BOTH COMMANDS EXECUTE IMMEDIATELY!
```

### With Bracketed Paste (SAFE)
```bash
# Same paste:
$ ls -la
$ rm -rf /
# ^ Text appears but doesn't execute
# You can review and edit before pressing Enter
```

## Switching to Emacs Mode

If you prefer emacs editing mode (default readline behavior):

1. Open `~/.inputrc`
2. Comment out lines 130-247 (Vi Mode section)
3. Uncomment lines 254-257 (Emacs Mode section)

```bash
# set editing-mode vi  # Comment this out
set editing-mode emacs  # Uncomment this
```

Emacs mode keybindings (default):
- `Ctrl-a/e` - Beginning/end of line
- `Ctrl-k` - Kill to end of line
- `Ctrl-u` - Kill to beginning
- `Ctrl-w` - Kill word backward
- `Alt-f/b` - Word forward/backward
- `Alt-d` - Kill word forward

## Testing Your Configuration

### Reload Configuration

```bash
# In bash, reload without restarting shell
# Press: Ctrl-x Ctrl-r

# Or reload manually
bind -f ~/.inputrc

# Or restart shell
exec bash
```

### Test Vi Mode

```bash
# Type some text
$ echo hello

# Type "jj" quickly → should enter command mode
# Cursor should change from bar (|) to block (█)

# Press "i" → back to insert mode
# Cursor should change to bar (|)

# Press "k" in command mode → previous history
# Press "j" → next history
```

### Test History Search

```bash
# Run some commands
git status
git log
git diff

# Type partial command and press Up
$ git<Up>
# Should cycle through "git diff", "git log", "git status"
```

### Test Completion

```bash
# Should be case-insensitive
$ cd ~/doc<Tab>
# Completes to ~/Documents/

# Should show all matches immediately
$ ls ~/D<Tab>
Desktop/    Documents/    Downloads/
# ^ No double-Tab needed
```

### Test Bracketed Paste

```bash
# Copy multiple lines from somewhere
# Paste into terminal
# Commands should appear but not execute immediately
```

## Troubleshooting

### Changes Not Taking Effect

```bash
# Reload configuration
bind -f ~/.inputrc

# Check for syntax errors
bind -f ~/.inputrc 2>&1 | grep -i error

# Restart shell
exec bash
```

### Vi Mode Not Working

```bash
# Check editing mode
bind -v | grep editing-mode
# Should show: set editing-mode vi

# Make sure vi mode is uncommented in ~/.inputrc
grep "^set editing-mode vi" ~/.inputrc
```

### History Search Not Working

```bash
# Check bindings
bind -p | grep history-search
# Should show arrow key bindings

# Test key sequence
$ <Ctrl-v><Up>
# Shows: ^[[A
# Should match "\e[A" in config
```

### Cursor Shape Not Changing

Requires:
1. Readline 7.0+ (bash 5.0+)
2. Terminal with cursor shape support (iTerm2, Alacritty, Kitty, Wezterm)
3. `show-mode-in-prompt on` in config

```bash
# Check readline version
bash --version
# Need: GNU bash, version 5.0+

# Check if terminal supports cursor shapes
# Should see cursor change:
echo -e "\e[6 q"  # Vertical bar
echo -e "\e[2 q"  # Block
```

### Completions Not Colorized

```bash
# Check LS_COLORS is set
echo $LS_COLORS
# Should show color definitions

# If not set, add to shell config
eval "$(dircolors)"  # Linux
# or
eval "$(vivid generate catppuccin-mocha)"  # Modern alternative
```

### Key Binding Not Working

Find the actual key sequence:

```bash
# Press Ctrl-v then the key
$ <Ctrl-v><Ctrl-Left>
# Shows: ^[[1;5D

# Use this in .inputrc
"\e[1;5D": backward-word
```

## Advanced Customization

### Application-Specific Bindings

```bash
# Python REPL
$if Python
    # Ctrl-j: newline for multi-line commands
    Control-j: "\n"
$endif

# MySQL
$if mysql
    # Ctrl-d: quit
    Control-d: "quit\n"
$endif

# PostgreSQL
$if psql
    # Ctrl-d: exit
    Control-d: "\\q\n"
$endif
```

### Custom Keybindings

```bash
# Vi insert mode custom bindings
set keymap vi-insert
"jk": vi-movement-mode              # Alternative escape
"\e[1;3C": forward-word             # Alt-Right: word forward
"\e[1;3D": backward-word            # Alt-Left: word backward

# Vi command mode custom bindings
set keymap vi-command
"gg": beginning-of-history          # Go to first history
"G": end-of-history                 # Go to last history
"/": history-search-forward         # Search history
```

### Completion Cycling

Instead of showing all matches, cycle through them:

```bash
# Comment out: set show-all-if-ambiguous on
# Add:
TAB: menu-complete                  # Tab cycles forward
"\e[Z": menu-complete-backward      # Shift-Tab cycles backward
```

## Common Readline Functions

### Navigation
| Function | Description |
|----------|-------------|
| `beginning-of-line` | Move to start of line |
| `end-of-line` | Move to end of line |
| `forward-char` | Move forward one character |
| `backward-char` | Move backward one character |
| `forward-word` | Move forward one word |
| `backward-word` | Move backward one word |

### Editing
| Function | Description |
|----------|-------------|
| `delete-char` | Delete character under cursor |
| `backward-delete-char` | Delete character before cursor |
| `kill-line` | Delete to end of line |
| `unix-line-discard` | Delete to beginning of line |
| `kill-word` | Delete word forward |
| `backward-kill-word` | Delete word backward |
| `yank` | Paste previously killed text |

### History
| Function | Description |
|----------|-------------|
| `previous-history` | Previous command |
| `next-history` | Next command |
| `beginning-of-history` | First command in history |
| `end-of-history` | Last command in history |
| `reverse-search-history` | Incremental search backward |
| `forward-search-history` | Incremental search forward |
| `history-search-backward` | Search backward by prefix |
| `history-search-forward` | Search forward by prefix |

### Completion
| Function | Description |
|----------|-------------|
| `complete` | Attempt completion |
| `menu-complete` | Cycle through completions |
| `menu-complete-backward` | Cycle backward |
| `possible-completions` | List all completions |

### Vi Mode
| Function | Description |
|----------|-------------|
| `vi-movement-mode` | Enter vi command mode |
| `vi-insertion-mode` | Enter vi insert mode |
| `vi-append-mode` | Append after cursor |
| `vi-append-eol` | Append at end of line |
| `edit-and-execute-command` | Edit in $EDITOR |

### Other
| Function | Description |
|----------|-------------|
| `clear-screen` | Clear terminal screen |
| `redraw-current-line` | Redraw current line |
| `abort` | Cancel current action |

## Debugging

### Show All Bindings

```bash
# In bash
bind -p                 # Show all key bindings
bind -v                 # Show all variables
bind -l                 # List all function names
```

### Test Key Sequences

```bash
# What does this key send?
$ <Ctrl-v><key>
# Shows the escape sequence

# Examples:
<Ctrl-v><Up>           → ^[[A  (or \e[A)
<Ctrl-v><Ctrl-Left>    → ^[[1;5D
<Ctrl-v><Alt-f>        → ^[f
```

### Check Variable Values

```bash
bind -v | grep completion-ignore-case
# Output: set completion-ignore-case on

bind -v | grep editing-mode
# Output: set editing-mode vi
```

## Performance Tips

- **completion-query-items** - Set to 100-200 for good balance
- **page-completions** - Enable to prevent overwhelming output
- **colored-stats** - Minimal performance impact, worth it
- **bracketed-paste** - No performance impact, essential security

## Examples

### Minimal Configuration

Just the essentials:

```bash
set completion-ignore-case on
set colored-stats on
set bell-style none
"\e[A": history-search-backward
"\e[B": history-search-forward
```

### Emacs Mode Power User

```bash
set editing-mode emacs
set completion-ignore-case on
set show-all-if-ambiguous on
set colored-stats on
set visible-stats on
set bell-style none
set enable-bracketed-paste on
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[1;5C": forward-word
"\e[1;5D": backward-word
```

### Complete Vi Mode Setup

See `~/.inputrc` - this is what we use by default.

## Related Documentation

- [Bash Configuration](bash.md) - Shell configuration
- [Zsh Configuration](zsh.md) - Alternative shell
- [Vim Configuration](vim.md) - Text editor with similar keybindings

## Resources

- [GNU Readline Manual](https://tiswww.case.edu/php/chet/readline/rltop.html)
- [Bash Readline Init File](https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File.html)
- [Bindable Readline Commands](https://www.gnu.org/software/bash/manual/html_node/Bindable-Readline-Commands.html)
- [Readline Vi Mode](https://www.gnu.org/software/bash/manual/html_node/Readline-vi-Mode.html)

