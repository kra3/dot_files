# Linux Utility Scripts

Linux-specific utility scripts for desktop environment.

## Scripts

### i3lock-blur

Enhanced screen lock with blurred screenshot.

**Location**: `~/.local/bin/i3lock-blur`

**Features**:
- Takes screenshot of current desktop
- Applies blur effect (10% scale → 2.5px blur → resize to 1000%)
- Uses screenshot as lock screen background
- Falls back to black screen if screenshot fails

**Requirements**:
- `imagemagick` - For screenshot and blur effect (`import`, `convert` commands)
- `i3lock` - Screen locker

**Installation**:
```bash
sudo apt install imagemagick i3lock
```

**Usage**:
```bash
# Manual lock
~/.local/bin/i3lock-blur

# With i3 (keybinding already configured)
# Press: Super+Ctrl+L

# With xautolock (already configured in .xinitrc)
xautolock -time 5 -locker ~/.local/bin/i3lock-blur &
```

**Customization**:

To change blur strength, edit the script:
```bash
# Stronger blur
convert "$SCREENSHOT" -scale 10% -blur 0x5 -resize 1000% "$SCREENSHOT"

# Weaker blur
convert "$SCREENSHOT" -scale 20% -blur 0x1 -resize 500% "$SCREENSHOT"

# No blur (sharp screenshot)
# Comment out the convert line
```

### notify-listener.py

Desktop notification listener for irssi IRC messages.

**Location**: `~/.local/bin/notify-listener.py`

**Features**:
- Listens for irssi notifications via DBus
- Shows desktop notifications for mentions and private messages
- Plays sound alert (message-new-instant)
- Python 3 compatible

**Requirements**:
- `python3-gi` - PyGObject bindings
- `python3-dbus` - DBus Python bindings
- `gir1.2-notify-0.7` - Notification daemon
- `libcanberra-gtk-module` - Sound support
- `irssi` with `notify.pl` script

**Installation**:
```bash
# Install dependencies
sudo apt install python3-gi python3-dbus gir1.2-notify-0.7 libcanberra-gtk-module

# Install irssi notify.pl script
mkdir -p ~/.config/irssi/scripts/autorun
wget -O ~/.config/irssi/scripts/notify.pl https://scripts.irssi.org/scripts/notify.pl
ln -s ~/.config/irssi/scripts/notify.pl ~/.config/irssi/scripts/autorun/
```

**Usage**:
```bash
# Start manually (blocks terminal)
~/.local/bin/notify-listener.py

# Start in background
~/.local/bin/notify-listener.py &

# Auto-start (already configured in .xinitrc)
# Starts automatically when X11 session begins

# Stop
pkill -f notify-listener
```

**Irssi Configuration**:

The `notify.pl` script must be loaded in irssi. It's already configured in the autorun directory, so it loads automatically.

To verify:
```
# In irssi
/script list
# Should show: notify.pl
```

**Testing**:

1. Start the listener:
   ```bash
   ~/.local/bin/notify-listener.py &
   ```

2. In irssi, trigger a test notification:
   ```
   /notify_test
   ```

3. You should see a desktop notification and hear a sound

**Troubleshooting**:

If notifications don't appear:

1. Check listener is running:
   ```bash
   ps aux | grep notify-listener
   ```

2. Check irssi script is loaded:
   ```
   /script list
   ```

3. Check DBus is available:
   ```bash
   dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames
   ```

4. Check notification daemon is running:
   ```bash
   ps aux | grep -E 'dunst|notify-osd|notification-daemon'
   ```

## File Naming Convention

These scripts use chezmoi naming conventions:
- `executable_i3lock-blur.tmpl` → `~/.local/bin/i3lock-blur` (executable, Linux-only)
- `executable_notify-listener.py.tmpl` → `~/.local/bin/notify-listener.py` (executable, Linux-only)

The `executable_` prefix makes them executable (chmod +x).
The `.tmpl` suffix allows template conditionals (Linux-only via `{{- if eq .chezmoi.os "linux" -}}`).

## Integration

Both scripts are integrated into the dotfiles:

**i3lock-blur**:
- Called by `.xinitrc` via xautolock (auto-lock after 5 minutes)
- Bound to Super+Ctrl+L in i3 config
- Fallback to plain i3lock if script unavailable

**notify-listener.py**:
- Auto-started by `.xinitrc` on X11 session start
- Works with irssi `notify.pl` script via DBus
- No configuration needed if dependencies installed

## Legacy Scripts

These are modernized versions of legacy scripts from `_archive/bin-legacy/`:

**Changes from legacy**:
- `i3lock` → `i3lock-blur`: Added blur effect, better error handling, cleanup
- `notify-listener.py`: Python 3 compatible, better error messages, modern DBus API

**Removed scripts** (not relevant for modern setup):
- `tweet.sh` - Twitter posting (use web/mobile apps)
- `wikisole` - Wikipedia lookup (use browser)
