# Conky System Monitor Configuration

Modern conky setup with Catppuccin Mocha theme for Linux desktop monitoring.

## Configurations

### 1. Desktop Widget (`conky.conf`)

Desktop overlay displaying system information in the bottom-right corner.

**Features**:
- Dynamic CPU detection (supports 1-8+ cores)
- Memory and swap usage with bars
- Top processes by CPU and memory
- Disk usage (root, home)
- Network monitoring (auto-detects wlan0, eth0, enp0s31f6)
- Battery status (if present)
- Public IP address (updated hourly)
- Catppuccin Mocha color scheme
- JetBrainsMono Nerd Font

**Preview**:
```
nodename
Linux 6.x.x (x86_64)
Battery: 85% | Users: 2 | Uptime: 5d 3h

═══ SYSTEM ═══
Processes: 235 / 415
Load: 0.50 1.23 1.45

═══ CPU ═══
CPU 0: 2.4GHz          45%
[████████░░░░░░░░░░]
...

═══ MEMORY ═══
RAM: 8.2G / 16.0G     51%
[██████████░░░░░░░░]

═══ TOP PROCESSES ═══
...
```

### 2. Status Bar (`conky-status.conf`)

Single-line output for dwm or i3bar integration.

**Output format**:
```
Eth: 450KB↓ 120KB↑ | WiFi: 1.2MB↓ 350KB↑ | Bat: 85% | CPU: 23% @ 2.4GHz | Mem: 51% | /: 45% | Mon Oct 25 02:30pm
```

## Installation

**Debian/Ubuntu**:
```bash
sudo apt install conky-all
```

**Fedora/RHEL**:
```bash
sudo dnf install conky
```

**Arch**:
```bash
sudo pacman -S conky
```

## Usage

### Desktop Widget

**Manual start**:
```bash
conky -c ~/.config/conky/conky.conf
```

**Auto-start with i3**:
Add to `~/.config/i3/config`:
```bash
exec_always --no-startup-id conky -c ~/.config/conky/conky.conf
```

**Auto-start with dwm**:
Add to `~/.xinitrc`:
```bash
conky -c ~/.config/conky/conky.conf &
```

### Status Bar

**With dwm** (xsetroot integration):
```bash
conky -c ~/.config/conky/conky-status.conf | while read -r; do xsetroot -name "$REPLY"; done &
```

Add to `~/.xinitrc` before `exec dwm`.

**With i3bar**:
i3 has its own status bar (i3status, i3status-rs, i3blocks). Conky can replace these:

Add to `~/.config/i3/config`:
```
bar {
    status_command conky -c ~/.config/conky/conky-status.conf
    ...
}
```

## Customization

### Network Interfaces

If your network interfaces have different names, update the config:

```lua
conky.config = {
    ...
    template0 = 'wlp2s0',  -- Your WiFi interface
    template1 = 'enp3s0',  -- Your Ethernet interface
}
```

Then use `${template0}` and `${template1}` in the text section.

To find your interface names:
```bash
ip link show
```

### Colors

The configs use Catppuccin Mocha by default. To customize, edit these in `conky.config`:

```lua
default_color = 'cdd6f4',  -- Main text
color1 = '89b4fa',  -- Section headers (blue)
color2 = 'a6e3a1',  -- Success/download (green)
color3 = 'f9e2af',  -- Warnings (yellow)
color4 = 'f38ba8',  -- Critical/upload (red)
color5 = 'cba6f7',  -- Accent (mauve)
color6 = 'bac2de',  -- Subtext (gray)
```

### Position

Change widget position in `conky.config`:

```lua
alignment = 'bottom_right',  -- Options: top_left, top_right, bottom_left, bottom_right
gap_x = 20,  -- Horizontal gap from edge
gap_y = 20,  -- Vertical gap from edge
```

### Refresh Rate

```lua
update_interval = 5.0,  -- Seconds between updates (desktop)
update_interval = 2.0,  -- Seconds between updates (status bar)
```

### Font

```lua
font = 'JetBrainsMono Nerd Font:size=9',
```

Change to any installed font:
```bash
fc-list | grep -i "font name"
```

## Adding Custom Sections

### Temperature Monitoring

Add to `conky.text` in desktop config:

```lua
${color1}═══ TEMPERATURE ═══${color}
CPU: ${hwmon 0 temp 1}°C
${if_existing /sys/class/hwmon/hwmon1/temp1_input}\
GPU: ${hwmon 1 temp 1}°C
${endif}
```

### Disk I/O

```lua
${color1}═══ DISK I/O ═══${color}
Read: ${diskio_read} ${alignr}Write: ${diskio_write}
${diskiograph_read 30,140} ${alignr}${diskiograph_write 30,140}
```

### Additional Mount Points

```lua
${if_mounted /mnt/data}\
Data: ${fs_free /mnt/data} / ${fs_size /mnt/data} ${alignr}${fs_used_perc /mnt/data}%
${fs_bar 5 /mnt/data}
${endif}
```

## Troubleshooting

### Conky doesn't start

Check syntax:
```bash
conky -c ~/.config/conky/conky.conf -C
```

### Text overlapping or garbled

1. Enable double buffering:
```lua
double_buffer = true,
```

2. Check window transparency:
```lua
own_window_argb_value = 230,  -- Lower for more transparent (0-255)
```

### High CPU usage

Increase update interval:
```lua
update_interval = 10.0,  -- Update every 10 seconds instead of 5
```

### Network stats not showing

1. Check interface exists:
```bash
ip link show
```

2. Update interface name in config or use conditional checks (already done in modern config)

### No transparency

Requires compositor:
```bash
# Install picom (modern) or compton (legacy)
sudo apt install picom

# Start with i3 or dwm
exec_always --no-startup-id picom -b
```

## Legacy Config Migration

Archived legacy configs use old syntax (pre-1.10):
- `_archive/conky/conky_desktop` - Old syntax, hardcoded 8 cores, green theme
- `_archive/conky/conky_status` - Old syntax

Modern configs use:
- Lua-based configuration (1.10+)
- Dynamic CPU detection
- Catppuccin Mocha theme
- Auto-detecting network interfaces
- Conditional display for missing hardware

## Resources

- Conky documentation: https://conky.cc/
- Conky variables: https://conky.cc/variables
- Conky config settings: https://conky.cc/config_settings
- Catppuccin theme: https://github.com/catppuccin/catppuccin

## Examples

### Minimal Desktop Widget

For low-resource systems, create a minimal config showing only essentials:

```lua
conky.text = [[
${time %H:%M} | CPU: ${cpu}% | Mem: ${memperc}% | /: ${fs_used_perc /}%
]]
```

### Multi-Monitor Setup

For multiple monitors, adjust position:

```lua
-- Monitor 2 (right screen)
xinerama_head = 2,
alignment = 'top_right',
```

### Transparent Background

For fully transparent background:

```lua
own_window_transparent = true,
own_window_argb_visual = false,
```
