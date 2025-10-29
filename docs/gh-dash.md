# gh-dash - GitHub CLI Dashboard

Beautiful terminal UI dashboard for GitHub PRs, Issues, and Notifications.

## Quick Start

```bash
# Launch dashboard
gh dash

# Use specific config
gh dash --config ~/.config/gh-dash/custom.yml
```

## Features

- **Pull Requests** - View PRs by author, review status, involvement
- **Issues** - Track assigned, created, and involved issues
- **Live Preview** - See PR/issue details, diffs, and comments
- **Quick Actions** - Review, comment, merge, close from terminal
- **Keyboard Navigation** - Vim-style navigation (j/k/h/l)
- **Customizable** - Filters, sections, themes, key bindings
- **Catppuccin Mocha Theme** - Matches your dotfiles theme

## Key Bindings

### Navigation

| Key | Action |
|-----|--------|
| `j` / `↓` | Move down |
| `k` / `↑` | Move up |
| `h` / `←` | Previous section |
| `l` / `→` | Next section |
| `g` | Go to top |
| `G` | Go to bottom |
| `Ctrl+d` | Page down |
| `Ctrl+u` | Page up |

### Switching Views

| Key | Action |
|-----|--------|
| `1` | Pull Requests view |
| `2` | Issues view |
| `3` | Notifications view |
| `Tab` | Cycle through sections |

### Actions (PRs)

| Key | Action |
|-----|--------|
| `o` | Open PR in editor (locally) |
| `O` | Open PR in browser |
| `Enter` | Toggle preview pane |
| `d` | Show diff |
| `c` | Add comment |
| `C` | Checkout PR branch |
| `r` | Mark as ready for review |
| `m` | Merge PR |
| `W` | Close PR |
| `R` | Reopen PR |
| `x` | Toggle selection (multi-select) |

### Actions (Issues)

| Key | Action |
|-----|--------|
| `o` | Open issue in editor |
| `O` | Open issue in browser |
| `Enter` | Toggle preview pane |
| `c` | Add comment |
| `W` | Close issue |
| `R` | Reopen issue |

### Other

| Key | Action |
|-----|--------|
| `/` | Search/filter |
| `?` | Show help |
| `q` | Quit |
| `Ctrl+r` | Refresh |

## Configuration

Configuration file: `~/.config/gh-dash/config.yml`

### Custom Sections

Add custom PR/issue sections with GitHub search filters:

```yaml
prSections:
  - title: Urgent
    filters: is:open label:urgent author:@me
    limit: 10

  - title: Team PRs
    filters: is:open team:myorg/myteam
    limit: 15

issuesSections:
  - title: Bugs
    filters: is:open label:bug assignee:@me
    limit: 20
```

### GitHub Search Filters

Common filters:
- `is:open` / `is:closed` / `is:merged`
- `author:@me` / `author:username`
- `assignee:@me` / `assignee:username`
- `review-requested:@me`
- `involves:@me` - Participating in any way
- `label:bug` / `label:"high priority"`
- `repo:owner/name`
- `org:orgname`
- `team:org/team`
- `sort:updated-desc` / `sort:created-desc`

### Custom Key Bindings

Add shortcuts for common workflows:

```yaml
keybindings:
  prs:
    # Open PR in tmux popup
    - key: p
      command: >
        tmux display-popup -E -w 90% -h 90%
        'gh pr view <PR_NUMBER> && $SHELL'

    # Approve and merge
    - key: A
      command: >
        gh pr review <PR_NUMBER> --approve &&
        gh pr merge <PR_NUMBER> --squash

  issues:
    # Assign to me
    - key: a
      command: gh issue edit <ISSUE_NUMBER> --add-assignee @me
```

### Repository Paths

Map repos to local paths for quick checkout:

```yaml
repoPaths:
  myorg/webapp: ~/src/webapp
  myorg/api: ~/src/api
  myorg/mobile: ~/projects/mobile-app
```

### Theme Customization

Default config uses Catppuccin Mocha. Customize colors:

```yaml
theme:
  colors:
    text:
      primary: "#cdd6f4"
      secondary: "#bac2de"
      warning: "#f9e2af"
      success: "#a6e3a1"
      danger: "#f38ba8"
```

## Workflow Examples

### Daily Review Workflow

1. Launch gh-dash: `gh dash`
2. Press `1` for PRs
3. Navigate with `j/k` through "Needs My Review"
4. Press `Enter` to see preview
5. Press `d` to view diff
6. Press `c` to add review comment
7. Press `m` to merge if approved

### Issue Triage

1. Launch gh-dash: `gh dash`
2. Press `2` for Issues
3. Navigate through sections
4. Press `O` to open in browser for detailed editing
5. Press `c` to add quick comment

### PR Monitoring

1. Launch gh-dash: `gh dash`
2. Check "My Pull Requests" section
3. Monitor CI status (shows in columns)
4. Check review status
5. Merge when ready with `m`

## Integration with Tmux

### Popup Launcher

Add to your shell config (`~/.zshrc` or `~/.bashrc`):

```bash
# gh-dash in tmux popup
gh-popup() {
    if [ -n "$TMUX" ]; then
        tmux display-popup -E -w 95% -h 95% 'gh dash'
    else
        gh dash
    fi
}
alias ghd='gh-popup'
```

### Tmux Binding

Add to `~/.tmux.conf`:

```bash
# Launch gh-dash in popup (Ctrl+a D)
bind D display-popup -E -w 95% -h 95% 'gh dash'
```

## Tips & Tricks

### Multi-repo Monitoring

Create sections for different repos:

```yaml
prSections:
  - title: Frontend (webapp)
    filters: is:open repo:myorg/webapp
  - title: Backend (api)
    filters: is:open repo:myorg/api
  - title: Mobile
    filters: is:open repo:myorg/mobile
```

### Team Monitoring

Track team activity:

```yaml
prSections:
  - title: Team PRs
    filters: is:open team:myorg/platform
  - title: Team Needs Review
    filters: is:open team-review-requested:myorg/platform
```

### Priority Filtering

Use labels for priorities:

```yaml
issuesSections:
  - title: P0 - Critical
    filters: is:open label:P0
    limit: 5
  - title: P1 - High
    filters: is:open label:P1
    limit: 10
  - title: P2 - Medium
    filters: is:open label:P2
    limit: 15
```

### Auto-refresh

Config includes 30-minute auto-refresh. Change as needed:

```yaml
defaults:
  refetchIntervalMinutes: 15  # Refresh every 15 minutes
```

## Troubleshooting

### "Not authenticated to github.com"

Re-authenticate:
```bash
gh auth login -h github.com
```

### Config not loading

Check config syntax:
```bash
cat ~/.config/gh-dash/config.yml | yq '.'
```

Force specific config:
```bash
gh dash --config ~/.config/gh-dash/config.yml
```

### Slow performance

- Reduce `limit` in sections
- Increase `refetchIntervalMinutes`
- Narrow filters to specific repos

### Theme not applying

Ensure terminal supports true color:
```bash
echo $COLORTERM  # Should show "truecolor"
```

## Advanced Usage

### Debug Mode

```bash
gh dash --debug
# Check debug.log for issues
```

### Environment Variables

```bash
# Custom config location
export GH_DASH_CONFIG=~/.config/gh-dash/custom.yml

# GitHub host (for enterprise)
export GH_HOST=github.company.com
```

## Resources

- GitHub: https://github.com/dlvhdr/gh-dash
- Config file: `~/.config/gh-dash/config.yml`
- GitHub search syntax: https://docs.github.com/en/search-github/getting-started-with-searching-on-github

## Shell Aliases

Add to `~/.zshrc` or `~/.bashrc`:

```bash
# Quick launch
alias ghd='gh dash'

# Open in tmux popup
alias ghdp='tmux display-popup -E -w 95% -h 95% gh dash'

# Launch with specific view
alias ghdp='gh dash'  # Default: PRs
alias ghdi='gh dash'  # Start in issues (press 2)
```
