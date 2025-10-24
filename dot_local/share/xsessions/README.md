# dwm Desktop Entry

Desktop entry file for dwm (Dynamic Window Manager) to appear in display manager session list.

## Location

User-specific: `~/.local/share/xsessions/dwm.desktop`

This allows dwm to appear as a session option when logging in via a display manager (GDM, LightDM, SDDM).

## System-wide Installation (Optional)

For system-wide availability (all users), copy to system location:

```bash
sudo cp ~/.local/share/xsessions/dwm.desktop /usr/share/xsessions/
```

## Requirements

1. **dwm must be installed** and available in PATH:
   ```bash
   # Check if dwm is installed
   which dwm

   # If not, install from source:
   # https://dwm.suckless.org/
   ```

2. **Display manager** must be installed:
   - GDM (GNOME Display Manager)
   - LightDM
   - SDDM (KDE's display manager)
   - XDM
   - Or others

3. **.xinitrc** must be configured (already done in dotfiles):
   - `~/.xinitrc` handles X11 session initialization

## Usage

### With Display Manager

1. Log out
2. At login screen, click session selector (usually gear icon)
3. Select "dwm"
4. Log in

### Without Display Manager (startx)

If using `startx` instead of a display manager:

```bash
# Edit ~/.xinitrc to add at the end:
exec dwm
```

Then:
```bash
startx
```

## dwm Configuration

dwm is configured by editing `config.h` and recompiling. See https://dwm.suckless.org/ for details.

**Basic workflow**:
1. Clone dwm source
2. Edit `config.h`
3. Run `sudo make clean install`
4. Log out and back in

## Troubleshooting

### dwm doesn't appear in session list

1. **Check file location**:
   ```bash
   ls -la ~/.local/share/xsessions/dwm.desktop
   ```

2. **Verify dwm is installed**:
   ```bash
   which dwm
   ```

3. **Check display manager looks at user xsessions**:
   Some display managers only read from `/usr/share/xsessions/`. If so, use system-wide installation.

4. **Restart display manager**:
   ```bash
   # GDM
   sudo systemctl restart gdm

   # LightDM
   sudo systemctl restart lightdm

   # SDDM
   sudo systemctl restart sddm
   ```

### dwm starts but screen is blank

Check `~/.xinitrc` is properly configured. Common issues:
- Missing `xrdb -merge ~/.Xresources`
- Missing compositor (picom)
- Incorrect final `exec dwm` line

### Keybindings don't work

dwm uses custom keybindings defined in its `config.h`. Default:
- `Alt+Shift+Return` - Open terminal
- `Alt+p` - dmenu launcher
- `Alt+Shift+c` - Close window
- `Alt+Shift+q` - Quit dwm

Check your compiled dwm's config.h for your keybindings.

## Related Files

- `~/.xinitrc` - X11 session initialization
- `~/.Xresources` - X11 resources (colors, fonts)
- `~/.config/i3/config` - Alternative tiling WM (if not using dwm)

## References

- dwm homepage: https://dwm.suckless.org/
- dwm tutorial: https://dwm.suckless.org/tutorial/
- Desktop Entry spec: https://specifications.freedesktop.org/desktop-entry-spec/
