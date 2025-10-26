# Git Configuration Documentation

Modern Git 2.37+ configuration with delta, difftastic, and powerful aliases.

## Features

- **Delta diff pager** - Syntax highlighting, line numbers, side-by-side diffs
- **Difftastic integration** - Structural, syntax-aware diffs
- **git-absorb** - Automatic fixup commits
- **Modern Git 2.37+ features** - autoSetupRemote, autoStash, autoSquash
- **Powerful aliases** - 50+ time-saving shortcuts
- **Smart credential management** - GitHub CLI integration
- **Work/personal profiles** - Separate configs via includes

## Configuration Files

### `.gitconfig`

Main configuration (managed by chezmoi):
- User identity (work vs personal)
- Core settings
- Aliases
- Color schemes
- Delta configuration
- Credential helpers

### `.gitconfig.work` (Local)

Work-specific overrides (not tracked in git):
- Enterprise GitHub credentials
- GPG signing with company tools
- Internal repositories

Example:
```ini
[credential "https://github.enterprise.com"]
    helper = !gh auth git-credential

[gpg "x509"]
    program = /usr/local/bin/company-sign

[gpg]
    format = x509
```

### `.gitconfig.local` (Personal)

Personal overrides, secrets, and signing keys (kept out of version control):
```ini
[user]
    signingkey = ABCDEF1234567890

[commit]
    gpgsign = true
```

Place this file at `~/.gitconfig.local`; chezmoi ignores it, but the main template includes it so Git loads the settings automatically.

## Core Settings

```ini
[init]
    defaultBranch = main

[core]
    pager = delta                  # Use delta for diffs
    excludesfile = ~/.gitignore_global
    ignorecase = false             # Case-sensitive file names

[push]
    default = current              # Push current branch
    autoSetupRemote = true         # Auto-track on first push (Git 2.37+)

[pull]
    rebase = true                  # Rebase instead of merge

[fetch]
    prune = true                   # Auto-prune deleted branches
    prunetags = true               # Prune deleted tags too

[rebase]
    autoStash = true               # Auto-stash/unstash when rebasing
    autoSquash = true              # Auto-squash fixup! commits

[branch]
    sort = -committerdate          # Sort branches by date (newest first)

[merge]
    conflictstyle = diff3          # Show common ancestor in conflicts
    tool = vimdiff

[rerere]
    enabled = true                 # Reuse recorded resolution
```

## Diff Tools

### Delta (Default)

Modern diff pager with syntax highlighting.

```ini
[delta]
    navigate = true                # Use n/N to move between sections
    line-numbers = true
    side-by-side = false           # Unified diff by default
    syntax-theme = Monokai Extended
```

Usage:
```bash
git diff                           # Automatic (via core.pager)
git show HEAD
git log -p
```

Key bindings in delta:
- `n` - Next diff section
- `N` - Previous diff section
- `q` - Quit

### Difftastic (Structural)

Syntax-aware structural diff.

```ini
[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"
```

Usage:
```bash
git dft                            # Alias for difftastic
git difftool --tool=difftastic
```

**When to use:**
- Refactoring (function moves, renames)
- Complex code changes
- Nested structures

## Essential Aliases

### Status & Info

```bash
git st                             # Status (short, branch)
git b                              # Branch list
git ba                             # All branches (local + remote)
git branches                       # All branches
git currentbranch                  # Current branch name
git r                              # Remote list
git tags                           # Tag list
```

### Commit

```bash
git ci                             # Commit
git amend                          # Amend last commit
git wip                            # Quick WIP commit (git add . && commit)
git fixup                          # Interactive fixup with fzf
git absorb                         # Automatic fixup (git-absorb)
```

### Branch & Checkout

```bash
git co <branch>                    # Checkout
git sw <branch>                    # Switch (Git 2.23+)
git swc <branch>                   # Switch + create
git coo                            # Checkout with fzf (recent branches)
git cm                             # Checkout main
git nb <branch>                    # New branch
```

### Diff

```bash
git df                             # Diff
git dc                             # Diff cached (staged)
git ds                             # Diff staged
git dw                             # Diff word-by-word
git dl                             # Diff last commit (HEAD~1)
git dft                            # Difftastic (structural)
git changes                        # Changed files (name-status)
git patch                          # Diff without colors (for patches)
```

### Add & Reset

```bash
git a <file>                       # Add
git aa                             # Add all
git ap                             # Add patch (interactive)
git unstage                        # Unstage
git undo                           # Undo last commit (soft reset)
```

### Stash

```bash
git sl                             # Stash list
git sp                             # Stash pop
git ss                             # Stash save
git sa                             # Stash apply
```

### Log & History

```bash
git l                              # Log (oneline, graph, last 10)
git ll                             # Log (oneline, graph, all)
git lg                             # Log (pretty, graph, colors)
```

### Branch Cleanup

```bash
git cleanup                        # Delete merged branches (except main/master/develop)
git gone                           # Delete branches where remote is gone (force)
```

### Publishing

```bash
git publish                        # Push and set upstream
git unpublish                      # Delete remote branch
```

## Advanced Workflows

### Fixup Commits

**Interactive (fzf):**
```bash
git fixup
# Shows recent commits with fzf
# Select commit to fixup
# Creates: commit --fixup=<sha>
# Then: git rebase -i --autosquash
```

**Automatic (git-absorb):**
```bash
# Make changes
git add -u
git absorb
# Automatically creates fixup commits
# And rebases to squash them
```

**When to use:**
- Fixing typos in recent commits
- Splitting changes across multiple commits
- Cleaning up PR before merge

### Branch Management

**List branches by date:**
```bash
git branch --sort=-committerdate
# or
git b
```

**Cleanup merged branches:**
```bash
# Safe cleanup (only fully merged)
git cleanup

# Remove branches where remote is gone (force delete, dangerous!)
git gone
```

### Worktrees

Use **lazygit** for worktree management:
- Open lazygit in your repo
- Navigate to branch view
- Press `w` to create/manage worktrees
- Visual, interactive interface

**Benefits:**
- Work on multiple branches simultaneously
- No stashing needed
- Separate build artifacts

Manual worktree commands:
```bash
# Create worktree
git worktree add ../repo-feature feature-branch

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../repo-feature

# Prune stale worktrees
git worktree prune
```

## Cherry-Pick & Rebase

```bash
# Cherry-pick
git cp <sha>
git cherry-pick <sha>

# Interactive rebase (autosquash enabled)
git rebase -i HEAD~5
# Automatically marks fixup! commits
```

## Credential Management

### GitHub (Personal & Work)

```ini
[credential "https://github.com"]
    helper = !gh auth git-credential
```

Setup:
```bash
# Personal account
gh auth login

# Work account (in work repo, with enterprise GitHub)
GH_HOST=github.enterprise.com gh auth login
```

### Work-Specific Credentials

In `~/.gitconfig.work`:
```ini
[credential "https://github.enterprise.com"]
    helper = !gh auth git-credential
```

## Commit Signing

### Personal (GPG)

```ini
[commit]
    gpgsign = true
```

Terminal shells export `GPG_TTY=$(tty)` when `gpg` is available so pinentry prompts work on both macOS and Linux.

Setup:
```bash
# Generate key
gpg --gen-key

# List keys
gpg --list-secret-keys --keyid-format LONG

# Set in git
git config --global user.signingkey <KEY_ID>

# Add to GitHub
gpg --armor --export <KEY_ID> | pbcopy
```

### Work (Company Tools)

In `~/.gitconfig.work`:
```ini
[gpg "x509"]
    program = /usr/local/bin/company-sign

[gpg]
    format = x509

[commit]
    gpgsign = true
```

## Color Schemes

### Delta Theme

```ini
[delta]
    syntax-theme = Monokai Extended
    features = decorations

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = cyan box ul
```

### Git Colors

```ini
[color "branch"]
    current = yellow reverse
    local = yellow
    remote = green

[color "diff"]
    meta = 227
    frag = magenta bold
    old = red bold
    new = green bold
```

## Global Gitignore

Create `~/.gitignore_global`:

```
# macOS
.DS_Store
.AppleDouble
.LSOverride

# IDE
.idea/
*.swp
*.swo
*~
.vscode/

# Build
*.o
*.pyc
__pycache__/
node_modules/
dist/
build/

# Env
.env
.env.local
```

Activate:
```ini
[core]
    excludesfile = ~/.gitignore_global
```

## Tips & Tricks

### Quick Status

```bash
git st
# On branch main
# Your branch is up to date with 'origin/main'.
# nothing to commit, working tree clean
```

### Interactive Staging

```bash
git ap
# Stage hunks interactively
# y - stage this hunk
# n - don't stage
# s - split into smaller hunks
# e - manually edit hunk
```

### Search Commits

```bash
# Search commit messages
git log --grep="fix"

# Search code changes
git log -S"function_name"

# Search by author
git log --author="Arun"
```

### Diff Statistics

```bash
git diff --stat
git show --stat HEAD
```

### Branch Tracking

```bash
# Auto-track on first push (Git 2.37+)
git push
# Sets up tracking automatically

# Manual tracking
git branch -u origin/main
```

### Rebase onto Main

```bash
# Update feature branch with main
git sw feature-branch
git rebase main

# With autostash (configured)
# Automatically stashes and unstashes
```

## Troubleshooting

### Delta Not Showing

Check pager:
```bash
git config --get core.pager
# Should show: delta
```

Test manually:
```bash
git diff | delta
```

### Credentials Not Working

Check helpers:
```bash
git config --get-regexp credential
```

Re-authenticate:
```bash
gh auth login
```

### Commit Signing Failing

Check GPG key:
```bash
git config --get user.signingkey
gpg --list-secret-keys
```

Disable temporarily:
```bash
git commit --no-gpg-sign
```

### Merge Conflicts

With diff3 style:
```
<<<<<<< HEAD
my changes
||||||| base
original
=======
their changes
>>>>>>> branch
```

**Middle section** shows original code for context.

Resolve:
```bash
# Edit files
vim conflicted-file

# Mark resolved
git add conflicted-file

# Continue
git rebase --continue
# or
git merge --continue
```

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [Delta](https://github.com/dandavison/delta)
- [Difftastic](https://github.com/Wilfred/difftastic)
- [git-absorb](https://github.com/tummychow/git-absorb)
- [GitHub CLI](https://cli.github.com/)
- Config file: `~/.gitconfig`
- Work config: `~/.gitconfig.work` (local)
