# Irssi IRC Client Configuration

Modern IRC setup with Libera.Chat (former Freenode community), SSL/TLS enabled, and enhanced functionality via Perl scripts.

## Quick Start

### Installation

**Linux (Debian/Ubuntu)**:
```bash
sudo apt install irssi irssi-scripts
```

**Linux (Fedora/RHEL)**:
```bash
sudo dnf install irssi irssi-devel
```

**macOS**:
```bash
brew install irssi
```

### First Connection

```bash
# Launch irssi
irssi

# Connect to Libera.Chat (modern FOSS IRC network)
/connect liberachat

# Register your nick
/msg NickServ REGISTER your_password your_email@example.com

# Check your email and verify
/msg NickServ VERIFY REGISTER yournick verification_code

# Join a channel
/join #linux
```

### Auto-identification Setup

Edit `~/.config/irssi/config` and uncomment this line in the `LiberaChat` chatnet section:

```
autosendcmd = "/^msg NickServ IDENTIFY your_password_here;wait 2000";
```

**Security note**: Store passwords in a local config file instead:
1. Create `~/.config/irssi/config.local` (not tracked in git)
2. Add server/chatnet overrides with passwords
3. Include in main config: `/include config.local`

## Included Scripts

Scripts are loaded automatically from `~/.config/irssi/scripts/autorun/`:

### Core Scripts (Auto-load)

1. **adv_windowlist.pl** - Advanced window list with activity indicators
   - Shows all windows in status bar
   - Color-coded activity levels
   - Usage: Automatic

2. **hilightwin.pl** - Dedicated highlight/mention window
   - Copies all highlights to window #2
   - Never miss a mention
   - Usage: Automatic

3. **usercount.pl** - Display user count in channels
   - Shows number of users in status bar
   - Useful for busy channels
   - Usage: Automatic

4. **xchatnickcolor.pl** - Colored nicknames
   - Assigns consistent colors to users
   - Improves readability
   - Usage: Automatic

### Optional Scripts (Manual load)

5. **nicklist.pl** - Display user list in tmux/screen split
   - Requires tmux or screen
   - Usage: `/script load nicklist`
   - Configure: `/set nicklist_automode SCREEN`

6. **spell.pl** - Spell checking before sending
   - Requires: `aspell` or `ispell`
   - Usage: `/script load spell`
   - Check word: `/spell word`

## Key Bindings

| Key | Action |
|-----|--------|
| `Alt-1` to `Alt-0` | Switch to window 1-10 |
| `Alt-q` to `Alt-o` | Switch to window 11-19 |
| `/win 5` | Go to window 5 |
| `Ctrl-n` / `Ctrl-p` | Next/previous window |
| `Ctrl-up` / `Ctrl-down` | Scroll nicklist (if loaded) |
| `Page Up` / `Page Down` | Scroll buffer |

## Useful Aliases

Defined in config:

| Alias | Command | Description |
|-------|---------|-------------|
| `/j #channel` | `/join #channel` | Join channel |
| `/wg 5` | `/window goto 5` | Go to window 5 |
| `/q nick` | `/query nick` | Open private message |
| `/c` | `/clear` | Clear window |
| `/wi nick` | `/whois nick nick` | Full whois info |

## IRC Networks

Default networks configured (all with SSL/TLS):

- **Libera.Chat** - FOSS community (former Freenode) - **Default**
- **OFTC** - Open and Free Technology Community
- **IRCnet** - One of the oldest networks
- **EFNet**, **Undernet**, **DALnet**, **QuakeNet**, **Rizon** - Legacy networks

## Logging

Auto-logging is enabled by default:
- Location: `~/irclogs/YEAR/NETWORK/CHANNEL.MONTH-DAY.log`
- Example: `~/irclogs/2025/LiberaChat/#linux.10-25.log`

Disable: `/set autolog off`

## Themes

Default theme is used. Alternative themes:

1. **xchat** - XChat-inspired theme (archived in `_archive/irssi/xchat.theme`)
2. **Modern themes**: https://irssi-import.github.io/themes/

To apply a theme:
```bash
# Copy theme to ~/.config/irssi/
cp mytheme.theme ~/.config/irssi/

# Apply in irssi
/set theme mytheme
```

## Advanced Features

### Tmux/Screen Integration

The nicklist script can display the user list in a tmux/screen split:

```bash
# In irssi
/script load nicklist
/nicklist screen
```

Then in tmux, the nicklist appears in a separate pane.

### Desktop Notifications

For desktop notifications of mentions/messages, install:

**Linux**:
```bash
sudo apt install libnotify-bin  # Debian/Ubuntu
```

Then load `notify.pl` script (not included in dotfiles, download from scripts.irssi.org).

### Bitlbee Integration (Optional)

Bitlbee allows connecting to other chat protocols (Discord, Slack, Matrix) through IRC:

**Installation**:
```bash
# Linux
sudo apt install bitlbee

# macOS
brew install bitlbee
```

**Setup**:
```bash
# Start bitlbee
systemctl start bitlbee  # Linux
bitlbee -D  # macOS

# Connect from irssi
/connect localhost 6667

# In &bitlbee channel
help quickstart
```

**Protocols supported**: Discord (via plugin), Matrix (via plugin), XMPP, more.

Bitlbee scripts in archive (optional):
- `bitlbee_autoreply.pl` - Auto-reply when away
- `bitlbee_status_notice.pl` - Status change notifications
- `bitlbee_tab_completion.pl` - Tab completion for IM contacts
- `bitlbee_typing_notice.pl` - Typing indicators

## Common IRC Commands

| Command | Description |
|---------|-------------|
| `/connect liberachat` | Connect to Libera.Chat |
| `/join #channel` | Join channel |
| `/part` | Leave current channel |
| `/query nick` | Open private message |
| `/msg nick message` | Send private message |
| `/nick newnick` | Change nickname |
| `/quit` | Disconnect and exit |
| `/away reason` | Mark as away |
| `/back` | Mark as back |

## Troubleshooting

### SSL/TLS Certificate Errors

If you see certificate verification errors:

```bash
# Temporary (insecure)
/server add -tls -notls_verify liberachat irc.libera.chat 6697

# Permanent fix: Install CA certificates
sudo apt install ca-certificates  # Linux
```

### Script Errors

If scripts fail to load:

```bash
# Check Perl dependencies
perl -MCPAN -e 'install Time::Duration'  # For some scripts
```

### Nick Already in Use

If your nick is taken (probably you, disconnected):

```bash
/nick mynick_
/msg NickServ IDENTIFY password
/nick mynick
/msg NickServ GHOST mynick_ password
```

## Resources

- Irssi documentation: https://irssi.org/documentation/
- Irssi scripts: https://scripts.irssi.org/
- Libera.Chat: https://libera.chat/
- IRC tutorial: https://www.irchelp.org/

## Migration from Archive

Archived legacy config includes:
- Freenode setup (network shut down in 2021)
- Bitlbee Twitter integration (API restrictions)
- Legacy themes (xchat, default)

Modern config uses:
- Libera.Chat (Freenode successor)
- SSL/TLS by default
- Templated personal information
- Essential scripts only
