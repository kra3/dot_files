# Readline Configuration Documentation

Configuration for GNU Readline library used by bash, python, mysql, psql, and many other programs.

## Overview

**File:** `~/.inputrc`

Readline is a library used by many command-line programs for line editing and history. Configuring `~/.inputrc` affects **all** readline-enabled programs, not just bash.

## Programs That Use Readline

- bash (interactive shell)
- python REPL
- mysql / psql / sqlite3 (database CLIs)
- gdb (debugger)
- ftp, sftp
- bc (calculator)
- And many more...

## Configuration

### Completion Behavior

```bash
# Case-insensitive completion
set completion-ignore-case on

# Show all matches on first Tab (no double-tab needed)
set show-all-if-ambiguous on

# Colorize completion list using LS_COLORS
set colored-stats on

# Add / to symlinked directories
set mark-symlinked-directories on

# Show file type indicators
# @ = symbolic link
# * = executable
# / = directory
set visible-stats on

# Color the common completion prefix (bash 4.4+)
set colored-completion-prefix on

# Show prefix before cycling through completions (bash 4.4+)
set menu-complete-display-prefix on
```

**Example:**
```bash
# Before
$ ls ~/Doc<Tab><Tab>
Documents/  Downloads/

# After (with show-all-if-ambiguous)
$ ls ~/Doc<Tab>
Documents/  Downloads/
```

### History Search Bindings

```bash
# Up/Down arrows search history based on current input
"\e[A": history-search-backward
"\e[B": history-search-forward
```

**Usage:**
```bash
# Type partial command, then Up
$ git ch<Up>
# Shows: git checkout main (from history)

# Empty line, then Up
$ <Up>
# Shows: last command (normal behavior)
```

**Key sequences:**
- `"\e[A"` - Up arrow
- `"\e[B"` - Down arrow
- `"\e[C"` - Right arrow (not bound here)
- `"\e[D"` - Left arrow (not bound here)

### Display Settings

```bash
# No bell on completion
set bell-style none

# Page completions if too many
set page-completions on

# Ask before showing >100 completions
set completion-query-items 100
```

**Bell styles:**
- `none` - No bell
- `visible` - Flash the screen
- `audible` - Beep (default)

### Editing Mode

```bash
# Use emacs keybindings (default)
set editing-mode emacs

# For vi mode, use:
# set editing-mode vi
```

**Emacs mode keybindings:**
- `Ctrl+A` - Beginning of line
- `Ctrl+E` - End of line
- `Ctrl+K` - Kill to end of line
- `Ctrl+U` - Kill to beginning of line
- `Ctrl+W` - Kill word backward
- `Alt+D` - Kill word forward

**Vi mode:**
- Press `Esc` to enter command mode
- `hjkl` for navigation
- `i` to return to insert mode

### Miscellaneous Settings

```bash
# Immediately show matches without bell
set show-all-if-unmodified on

# Expand tilde to full path
set expand-tilde on

# Skip completed text when moving cursor (bash 5.0+)
set skip-completed-text on
```

## Advanced Customization

### Custom Key Bindings

You can bind keys to readline functions:

```bash
# Ctrl+Left/Right for word navigation
"\e[1;5C": forward-word
"\e[1;5D": backward-word

# Alt+Backspace to delete word
"\e\x7f": backward-kill-word
```

### Conditional Settings

Apply settings only for specific programs:

```bash
# Settings only for bash
$if Bash
    set show-all-if-ambiguous on
$endif

# Settings only for python
$if Python
    set editing-mode vi
$endif

# Settings based on terminal type
$if term=xterm
    "\eOH": beginning-of-line
    "\eOF": end-of-line
$endif
```

### Mode-Specific Settings

Different settings for different editing modes:

```bash
# Vi command mode mappings
set keymap vi-command
"gg": beginning-of-history
"G": end-of-history

# Vi insert mode mappings
set keymap vi-insert
"\C-l": clear-screen

# Back to default
set keymap emacs
```

## Common Readline Functions

| Function | Default Key | Description |
|----------|-------------|-------------|
| `beginning-of-line` | Ctrl+A | Move to start of line |
| `end-of-line` | Ctrl+E | Move to end of line |
| `forward-char` | Ctrl+F / Right | Move forward one char |
| `backward-char` | Ctrl+B / Left | Move backward one char |
| `forward-word` | Alt+F | Move forward one word |
| `backward-word` | Alt+B | Move backward one word |
| `kill-line` | Ctrl+K | Delete to end of line |
| `unix-line-discard` | Ctrl+U | Delete to start of line |
| `kill-word` | Alt+D | Delete word forward |
| `backward-kill-word` | Ctrl+W | Delete word backward |
| `clear-screen` | Ctrl+L | Clear the screen |
| `history-search-backward` | - | Search history backward |
| `history-search-forward` | - | Search history forward |

## Testing Your Configuration

### Check Current Settings

```bash
# In bash, show all readline settings
bind -v

# Show all key bindings
bind -p
```

### Test Completions

```bash
# Should be case-insensitive
cd ~/doc<Tab>  # completes to ~/Documents

# Should show all matches on first Tab
ls ~/D<Tab>
```

### Test History Search

```bash
# Run some git commands
git status
git log
git diff

# Type and search
git<Up>  # Should cycle through git commands
```

## Troubleshooting

### Changes Not Taking Effect

```bash
# Reload readline configuration
bind -f ~/.inputrc

# Or restart your shell
exec bash
```

### Check for Syntax Errors

```bash
# Test the file
bind -f ~/.inputrc
# Will show errors if any
```

### Key Sequences Not Working

Find the actual key sequence sent by your terminal:

```bash
# Press Ctrl+V then the key
$ ^V<Up>
# Shows: ^[[A

# Use this in .inputrc
"\e[A": history-search-backward
```

**Common escape sequences:**
- `\e` - Escape character
- `\C-` - Control key (e.g., `\C-a` for Ctrl+A)
- `\M-` - Meta/Alt key (e.g., `\M-f` for Alt+F)

### Completion Not Colorized

Check that `LS_COLORS` is set:

```bash
echo $LS_COLORS
# Should show color definitions
```

If not set, add to your shell config:

```bash
# Use eza or dircolors to generate
eval "$(dircolors)"
```

## Best Practices

1. **Test in a new shell** - Changes don't affect existing shells
2. **Keep it simple** - Start with basic settings, add as needed
3. **Document custom bindings** - Add comments for clarity
4. **Use conditional settings** - For program-specific behavior
5. **Backup before changes** - `cp ~/.inputrc ~/.inputrc.backup`

## Performance Considerations

- **completion-query-items** - Higher values = less prompting, more scrolling
- **page-completions** - Prevents overwhelming output
- **colored-stats** - Minimal performance impact

## Examples

### Minimal Configuration

```bash
# Just the essentials
set completion-ignore-case on
set colored-stats on
set bell-style none
```

### Power User Configuration

```bash
# Full-featured setup
set completion-ignore-case on
set show-all-if-ambiguous on
set colored-stats on
set visible-stats on
set mark-symlinked-directories on
set colored-completion-prefix on
set menu-complete-display-prefix on
set bell-style none
set completion-query-items 200
"\e[A": history-search-backward
"\e[B": history-search-forward
```

### Vi Mode Configuration

```bash
set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string "\1\e[6 q\2"
set vi-cmd-mode-string "\1\e[2 q\2"

# Vi mode mappings
set keymap vi-command
"gg": beginning-of-history
"G": end-of-history
"k": history-search-backward
"j": history-search-forward

set keymap vi-insert
"\C-l": clear-screen
"\C-a": beginning-of-line
"\C-e": end-of-line
```

## Resources

- [Readline Manual](https://tiswww.case.edu/php/chet/readline/rltop.html)
- [Bash Readline Init File](https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File.html)
- [Readline Key Bindings](https://www.gnu.org/software/bash/manual/html_node/Bindable-Readline-Commands.html)
- Config file: `~/.inputrc`
- Test command: `bind -f ~/.inputrc`
