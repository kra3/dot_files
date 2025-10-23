# Vim Configuration

Modern Vim 9 configuration with LSP support, 45 carefully curated plugins, and comprehensive language support.

> **Last Updated**: October 2025
> **Vim Version Required**: 9.0+
> **Config Location**: `~/.vimrc` (managed via chezmoi as `dot_vimrc`)

## Overview

This configuration provides a modern, efficient Vim experience with:

- **LSP Support**: Full Language Server Protocol integration via vim-lsp
- **6 Languages**: Python, Java, JavaScript/TypeScript, Scala, Shell, SQL
- **45 Plugins**: Organized, actively maintained plugins via vim-plug
- **Smart Defaults**: Performance-optimized settings
- **Cross-platform**: Works on macOS and Linux

### Philosophy

- **Fast startup**: Lazy loading where possible, disabled unused built-ins
- **Modern tooling**: LSP for IDE features, async completion, contemporary plugins
- **Sensible defaults**: Works well out of the box
- **Clear organization**: Folded sections, well-documented

## Quick Start

### First-Time Setup

```bash
# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
vim +PlugInstall +qall

# Language servers auto-install on first use via vim-lsp-settings
```

### Health Check

```vim
:HealthCheck
```

Shows Vim version, plugin status, external tools, and terminal capabilities.

## Language Support

### Python

**LSP**: `pyright-langserver` (auto-installs on first `.py` file)

**Features**:
- Type checking (basic mode)
- Auto-completion
- Go-to-definition
- Refactoring (rename)
- Auto-formatting with Black (if installed)

**Linting**: flake8, pylint (via ALE, if installed)

**Key Bindings**:
```vim
<Leader>r    Run current file with python3
<Leader>i    Run interactively with python3 -i
<Leader>fb   Format with Black (if available)
```

**Configuration**:
- Tab width: 4 spaces
- Text width: 88 (Black default)
- Auto-remove trailing whitespace on save

### Java

**LSP**: `eclipse-jdt-ls` (auto-installs on first `.java` file)

**Features**:
- Full Java language support
- Package management
- Build integration
- Auto-completion

**Key Bindings**:
```vim
<Leader>r     Compile and run current file
<Leader>jc    Generate Java class template with package
F9            Same as <Leader>r
```

**Configuration**:
- Tab width: 4 spaces
- Auto-generates package declarations

### JavaScript/TypeScript

**LSP**: `typescript-language-server` (auto-installs)

**Features**:
- ES6+ syntax support
- TSX/JSX support
- NPM integration
- Prettier formatting (via ALE)

**Key Bindings**:
```vim
<Leader>r     Run with node/ts-node
<Leader>nt    npm test (if package.json exists)
<Leader>ns    npm start
<Leader>nb    npm run build
```

**Configuration**:
- Tab width: 2 spaces
- Auto-detects package.json for NPM commands

### Scala

**LSP**: `metals` (auto-installs on first `.scala` file)

**Features**:
- Scala 2 & 3 support
- SBT integration
- Compiler diagnostics

**Key Bindings**:
```vim
<Leader>r     Run with scala
<Leader>sb    sbt run
<Leader>st    sbt test
<Leader>sc    sbt compile
```

**Configuration**:
- Tab width: 2 spaces

### Shell

**LSP**: `bash-language-server` (auto-installs on first `.sh` file)

**Features**:
- Bash syntax checking
- ShellCheck integration
- Function navigation

**Key Bindings**:
```vim
<Leader>r     Run with bash
<Leader>sc    Check with shellcheck (if installed)
```

**Configuration**:
- Tab width: 2 spaces
- Auto-chmod +x on save for .sh files

### SQL

**LSP**: `sqls` (auto-installs on first `.sql` file)

**Features**:
- SQL syntax validation
- Formatting with sqlformat (if installed)
- Database engine support (psql, sqlite3)

**Key Bindings**:
```vim
<Leader>sf    Format SQL (if sqlformat available)
<Leader>rp    Run with PostgreSQL
<Leader>rs    Run with SQLite
```

**Configuration**:
- Tab width: 2 spaces
- Comment style: `-- comment`

## LSP Features

### Navigation

```vim
gd              Go to definition
gD              Go to declaration
gr              Find references
gi              Go to implementation
gt              Go to type definition
K               Show hover documentation (type info, docs)
```

### Diagnostics

```vim
[d              Previous diagnostic
]d              Next diagnostic
<Leader>dd      Show document diagnostics list
```

### Code Actions

```vim
<Leader>rn      Rename symbol
<Leader>ca      Code actions
<Leader>cl      Code lens
<Leader>f       Format document (normal mode)
<Leader>f       Format selection (visual mode)
```

### Workspace

```vim
<Leader>ds      Document symbols
<Leader>ws      Workspace symbols
```

### Completion

- **Trigger**: Automatic after 200ms delay
- **Navigate**: `<Tab>` (next), `<Shift-Tab>` (previous)
- **Accept**: `<Enter>`
- **Close**: `<C-e>`
- **Omni-completion**: `<C-x><C-o>` (manual fallback trigger)

LSP completion integrates with asyncomplete for async, non-blocking suggestions.

**Omni Completion Fallback**: When LSP is unavailable, omni-completion provides language-specific completions for all 6 supported languages (Python, Java, JavaScript/TypeScript, Scala, Shell, SQL) plus CSS, HTML, Markdown, XML, and Ruby.

### Snippets

Snippet support via vim-vsnip with VSCode-format snippets:

```vim
<C-j>           Expand snippet
<C-l>           Jump to next placeholder
<C-h>           Jump to previous placeholder
```

**Features**:
- VSCode-compatible snippet format
- Ships with `friendly-snippets` (community snippet collection)
- Custom snippets: Create `.vsnip` files in `~/.vim/snippets/`
- Works seamlessly with asyncomplete

**Example snippets**:
- Python: `def`, `class`, `if`, `for`, `try`
- JavaScript: `func`, `arrow`, `promise`, `import`
- TypeScript: `interface`, `type`, `enum`
- Java: `class`, `method`, `for`, `try`

## Plugin List (45 Total)

### Core & General (2)

| Plugin | Purpose |
|--------|---------|
| vim-obsession | Session management |
| editorconfig-vim | EditorConfig support (.editorconfig files) |

### Navigation & Search (6)

| Plugin | Purpose |
|--------|---------|
| fzf | Fuzzy finder |
| fzf.vim | FZF integration for Vim |
| nerdtree | File explorer |
| nerdtree-git-plugin | Git status in NERDTree |
| vim-rooter | Auto-change to project root |
| easymotion | Efficient text navigation |

### Version Control (3)

| Plugin | Purpose |
|--------|---------|
| vim-fugitive | Core Git commands |
| vim-signify | Git changes in gutter |
| vim-rhubarb | GitHub integration |

### Editing & Text (8)

| Plugin | Purpose |
|--------|---------|
| vim-surround | Quoting/parenthesizing made easy |
| vim-repeat | Repeat plugin maps with `.` |
| vim-commentary | Comment stuff out |
| vim-abolish | Search/substitute variants |
| vim-unimpaired | Pairs of bracket mappings |
| auto-pairs | Auto insert/delete brackets |
| vim-peekaboo | Preview registers |
| undotree | Visualize undo history |

### Indentation (1)

| Plugin | Purpose |
|--------|---------|
| vim-indent-object | Text objects for indented blocks |

### Window & Buffer (4)

| Plugin | Purpose |
|--------|---------|
| vim-bufonly | Delete all buffers except current |
| vim-autoswap | Handle swap files intelligently |
| vim-bbye | Better buffer closing |
| vim-tmux-navigator | Seamless vim/tmux navigation |

### UI Enhancements (5)

| Plugin | Purpose |
|--------|---------|
| vim-airline | Enhanced statusline |
| vim-airline-themes | Airline theme collection |
| catppuccin | Catppuccin theme (matches tmux) |
| vim-sleuth | Auto-detect indentation |
| vim-highlightedyank | Highlight yanked text |

### Language Support (5)

| Plugin | Purpose |
|--------|---------|
| emmet-vim | HTML/CSS expansion |
| vim-scala | Scala syntax |
| python-syntax | Enhanced Python syntax |
| vim-javascript | JavaScript support |
| yats.vim | TypeScript support |

### LSP & Completion (7)

| Plugin | Purpose |
|--------|---------|
| vim-lsp | LSP client |
| vim-lsp-settings | Auto LSP configuration |
| asyncomplete.vim | Async completion framework |
| asyncomplete-lsp.vim | LSP source for asyncomplete |
| vim-vsnip | Snippet engine (VSCode format) |
| vim-vsnip-integ | Snippet integration with asyncomplete |
| friendly-snippets | Community snippet collection |

### Linting (1)

| Plugin | Purpose |
|--------|---------|
| ale | Asynchronous Lint Engine |

### Productivity & Utilities (3)

| Plugin | Purpose |
|--------|---------|
| vim-which-key | Keybinding helper - shows available key combinations |
| vimwiki | Personal wiki for note-taking and organization |
| vim-eunuch | Unix shell commands (:Delete, :Move, :Rename, :Chmod, etc.) |

## Key Bindings Reference

### Leader Key

```vim
let mapleader = "\<Space>"
```

Leader is **Space**.

### General Editing

```vim
;               Command mode (same as :)
<Leader>w       Fast save
<C-s>           Quick save (normal mode - requires stty -ixon in shell)
<C-s>           Quick save and return to insert (insert mode)
w!!             Save with sudo (command mode)
<Leader>z       Toggle fold
<Leader>fw      Remove trailing whitespace (all filetypes)
j               Move down by display line (not actual line)
k               Move up by display line (not actual line)
J               Join lines keeping cursor in place
<C-w>           Delete word backward (insert mode)
[om             Enable mouse for scrolling
]om             Disable mouse
```

**Note**: Python files auto-remove trailing whitespace on save.

### Search & Replace

```vim
<F7>            Toggle search highlighting
<Leader><CR>    Clear search highlighting
<Leader>sr      Replace word under cursor (normal)
<Leader>sr      Search/replace selection (visual)
<Leader>ss      Substitute within visual selection
<Leader>sc      Search word under cursor (quickfix)
:ReplaceAll pattern replacement    Replace all in current buffer
:ProjectReplace pattern replacement Replace across entire project
```

### Windows & Navigation

```vim
<Leader>h/j/k/l Window navigation (alternative to Ctrl)
<C-Left/Right>  Window navigation with arrows
<Leader>+       Increase window height
<Leader>-       Decrease window height
<Leader>>       Increase window width
<Leader><       Decrease window width
<Leader>wt      Toggle window layout (horiz/vert)
<Leader>we      Equal window sizes
```

### Buffers

```vim
<Leader>b       Buffer list (FZF)
<Leader>ba      Close all buffers
<Leader>cd      Change dir to current file
<Leader>rf      Rename current file
```

### Tabs

```vim
<Leader>tn      New tab
<Leader>to      Close other tabs
<Leader>tc      Close tab
<Leader>tm      Move tab (prompts for position)
<Leader>tl      Next tab
<Leader>th      Previous tab
<Leader>te      New tab with current buffer's directory
<Leader>1-9     Jump to tab 1-9
<Leader>0       Jump to last tab
```

### Files & Search

```vim
<Leader>/       Find files (FZF)
<Leader>ft      Find tags
<Leader>fm      Find marks
<Leader>fh      Find history
:Rg             Search with ripgrep (FZF integration)
```

**Note**: Use `:Rg <pattern>` to search file contents with ripgrep via FZF.

### NERDTree

```vim
<Leader>n       Toggle NERDTree
<Leader>nf      Find current file in NERDTree
```

### Git (Fugitive)

```vim
<Leader>gb      Git blame
<Leader>gc      Git commit
<Leader>gd      Git diff (split)
<Leader>gp      Git push
<Leader>gs      Git status
<Leader>gw      Git write (stage)
<Leader>gl      Git log
```

### Git Hunks (Signify)

```vim
<Leader>sj      Next hunk
<Leader>sk      Previous hunk
<Leader>sh      Toggle hunk highlighting
<Leader>st      Toggle signify
<Leader>sd      Show hunk diff
<Leader>su      Undo hunk
```

### Other Tools

```vim
<Leader>u       Toggle Undotree
<Leader>ct      Generate ctags
<Leader><Leader> EasyMotion 2-character search
<Leader>s       EasyMotion n-character search
<Leader>ej      EasyMotion jump down
<Leader>ek      EasyMotion jump up
```

### Vimwiki (Note-taking)

```vim
<Leader>ww      Open vimwiki index
<Leader>wt      Open vimwiki index in new tab
<Leader>ws      Select and open vimwiki index
<Leader>wd      Delete vimwiki file
<Leader>wr      Rename vimwiki file
<Enter>         Follow/create wiki link
<Backspace>     Go back to previous wiki page
```

**Shell integration**: Use `n` command from shell to quickly open vimwiki.

### Code Navigation

```vim
[m              Previous method/function
]m              Next method/function
<C-o>           Jump back (with location info)
<C-i>           Jump forward (with location info)
<Leader>]       Jump to tag under cursor
<Leader>[       Pop tag stack
```

**Note**: Method/function navigation patterns adapt to file type (Python, Java, JavaScript/TypeScript, Scala, SQL, Shell, Vim).

### Visual Mode

```vim
<               Dedent (and reselect)
>               Indent (and reselect)
J               Move block down
K               Move block up
```

### Spelling

```vim
<Leader>s+      Add word to dictionary
<Leader>s?      Show spelling suggestions
```

### ALE (Linting)

```vim
[e              Previous error
]e              Next error
<Leader>at      Toggle ALE
<Leader>af      Fix with ALE
<Leader>ad      Show error detail
```

### Terminal Mode (Vim 8+)

```vim
<Leader>tt      Open terminal
<Esc>           Exit terminal insert mode
<C-h>           Navigate to left window from terminal
<C-j>           Navigate to down window from terminal
<C-k>           Navigate to up window from terminal
<C-l>           Navigate to right window from terminal
```

## Custom Commands

### File Management

```vim
:Touch path/to/file             Create file and parent directories
:RenameFile                     Rename current file (<Leader>rf)
:SudoSave                       Save with sudo (<Leader>ss)
:FixWhitespace                  Remove trailing whitespace (<Leader>fw)
```

### Search & Replace

```vim
:ReplaceAll pattern replacement       Replace all in current buffer
:ProjectReplace pattern replacement   Replace across entire project (uses find)
```

### Session Management

```vim
:SaveSession name               Save current session
:LoadSession name               Load saved session (with tab completion)
```

Sessions stored in `~/.vim/sessions/`.

### Window Management

```vim
:ToggleWindowLayout             Toggle between horizontal/vertical splits (<Leader>wt)
```

### Configuration

```vim
:HealthCheck                    Check Vim setup (version, plugins, tools)
:GenerateLocalConfig            Create .vim.local template in current directory
```

### Git (via vim-eunuch)

```vim
:Delete                         Delete current file and buffer
:Move new/path                  Move/rename current file
:Rename newname                 Rename current file (alias for :Move)
:Chmod +x                       Change file permissions
:Mkdir path/to/dir              Create directory
:SudoWrite                      Write file using sudo
:SudoEdit                       Edit file using sudo
:Wall                           Write all buffers
```

## Configuration Details

### UI & Display

```vim
set number                  " Line numbers
set numberwidth=3           " Line number column width
set colorcolumn=120         " Visual guide at column 120
set cursorline              " Highlight current line (active window only)
set cursorcolumn            " Highlight current column (active window only)
set spell                   " Spell checking enabled
set spelllang=en            " English spell checking
set showcmd                 " Show command in status line
set showmatch               " Show matching brackets
set noshowmode              " Hide mode (airline shows it)
set termguicolors           " True color support
set nowrap                  " Don't wrap lines
set textwidth=0             " Don't auto-wrap text
```

**Window-specific**: Cursor line/column only show in active window, auto-disabled when switching windows.

### Performance Optimizations

```vim
set lazyredraw              " Don't redraw during macros
set ttyfast                 " Faster terminal connection
set synmaxcol=200           " Only highlight first 200 columns
set updatetime=300          " Faster git-gutter updates
```

### Search Settings

```vim
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive by default
set smartcase               " Case sensitive if pattern has caps
set wrapscan                " Wrap search at EOF
```

### Indentation

```vim
set tabstop=4               " Tab displays as 4 spaces
set softtabstop=4           " Insert 4 spaces for tab
set shiftwidth=4            " Indent with 4 spaces
set expandtab               " Use spaces, not tabs
set smartindent             " Smart indentation
```

Plus **vim-sleuth** auto-detects per-project settings.

### Backup & Undo

```vim
set nobackup                " No backup files
set noswapfile              " No swap files
set undofile                " Persistent undo
set undodir=~/.backup/vim/undo/
```

### Completion

```vim
set completeopt=menuone,noinsert,noselect,preview
```

### Folding

- **Default**: `foldmethod=indent`
- **Vim/tmux/conf**: `foldmethod=marker` (e.g., `{{{` `}}}`)
- **Syntax languages**: `foldmethod=syntax`
- **Markdown**: Custom fold expression (by header level)
- **Level**: `foldlevel=9` (start unfolded)

Toggle fold: `<Leader>z` or `za`

### Clipboard

```vim
set clipboard=unnamed,unnamedplus
```

System clipboard integration (works with `y`, `p`, etc.).

## File Type Settings

Each language has custom settings in the "File Type Specific Settings" section of `.vimrc`:

- **Python**: 4-space indent, textwidth=88, run with `<Leader>r`
- **Java**: 4-space indent, compile+run with `<Leader>r`, class generator
- **JavaScript/TypeScript**: 2-space indent, node/ts-node execution, npm integration
- **Scala**: 2-space indent, scala/sbt execution
- **Shell**: 2-space indent, bash execution, auto-chmod +x, shellcheck
- **SQL**: 2-space indent, sqlformat, psql/sqlite3 integration
- **Markdown**: Spell check, textwidth=80, browser preview

## Troubleshooting

### LSP Not Working

1. **Check language server installation**:
   ```vim
   :LspInstallServer
   ```

2. **Check LSP status**:
   ```vim
   :LspStatus
   ```

3. **View LSP logs**:
   ```vim
   :LspLog
   ```

4. **Common issues**:
   - Python: Ensure `pyright` or `pyright-langserver` is in PATH
   - Java: Requires Java 17+, may take time to download on first use
   - Node tools: Requires `npm` for typescript-language-server

### Plugins Not Loading

```vim
:PlugStatus          " Check plugin status
:PlugInstall         " Install missing plugins
:PlugUpdate          " Update all plugins
:PlugClean           " Remove unused plugins
```

### Slow Startup

1. **Profile startup**:
   ```bash
   vim --startuptime /tmp/vim-startup.log
   cat /tmp/vim-startup.log
   ```

2. **Check for slow plugins**:
   - Look for long load times in startup log
   - Consider lazy-loading more plugins

3. **Disable problematic plugins temporarily**:
   Comment out in `.vimrc` and run `:source ~/.vimrc`

### Completion Not Working

1. **Check asyncomplete**:
   ```vim
   :echo asyncomplete#get_source_info()
   ```

2. **Check LSP is running** (see above)

3. **Trigger manually**: `<C-x><C-o>` (omni-completion)

### ALE Conflicts with LSP

This config already handles this:
```vim
let g:ale_disable_lsp = 1
```

ALE does linting only, LSP handles IDE features.

### Terminal Colors Wrong

```vim
:set termguicolors?      " Check if true color enabled
:echo $TERM              " Should be xterm-256color or similar
```

If colors are wrong:
1. Check terminal supports 256 colors
2. Set `export TERM=xterm-256color` in shell config
3. Try `:set notermguicolors` in vim

## Advanced Usage

### Custom Functions

#### Health Check

```vim
:HealthCheck
```

Shows Vim version, plugins, external tools, terminal capabilities.

### Session Management

```vim
:SaveSession mysession      " Save session
:LoadSession mysession      " Load session
```

Sessions stored in `~/.vim/sessions/`.

### Project-Specific Config

Create `.vim.local` or `.lvimrc` in project root:

```vim
" Example .vim.local
setlocal tabstop=2
setlocal shiftwidth=2
let b:ale_linters = {'javascript': ['eslint']}
nnoremap <buffer> <Leader>r :!npm run dev<CR>
```

Auto-loads when opening files in that directory.

Generate template:
```vim
:GenerateLocalConfig
```

### Replace Across Project

```vim
:ProjectReplace old_pattern new_pattern
```

Searches all files and replaces pattern project-wide.

### File Management

**Built-in commands**:
```vim
:Touch path/to/file         " Create file and parent dirs
:RenameFile                 " Rename current file
:SudoSave                   " Save with sudo (if forgot to open with sudo)
:FixWhitespace              " Remove trailing whitespace from current buffer
```

**vim-eunuch commands**:
```vim
:Delete                     " Delete current file and buffer
:Move new/path              " Move/rename current file
:Rename newname             " Rename current file (alias for :Move)
:Chmod +x                   " Change file permissions
:Mkdir path/to/dir          " Create directory
:SudoWrite                  " Write file using sudo
:SudoEdit                   " Edit file using sudo
:Wall                       " Write all buffers
```

**Trailing Whitespace**:
- Command: `:FixWhitespace` or `<Leader>fw`
- Works on any buffer (not just Python)
- Python files auto-strip on save
- Other filetypes require manual cleanup

### Window Layout Toggle

```vim
<Leader>wt                  " Toggle horizontal/vertical splits
```

## External Tools

### Required

- **git**: Version control
- **vim-plug**: Plugin manager

### Recommended

- **ripgrep** (`rg`): Fast search (10-100x faster than grep)
- **ctags**: Tag generation for code navigation
- **fzf**: Fuzzy finder integration

### Language-Specific

- **Python**: python3, black (formatter), flake8 (linter), pylint
- **Java**: JDK 17+
- **JavaScript/TypeScript**: node, npm, ts-node
- **Scala**: scala, sbt
- **Shell**: bash, shellcheck
- **SQL**: psql (PostgreSQL), sqlite3, sqlformat

### Optional

- **lazygit**: Terminal UI for git
- **delta**: Better git diffs

## Related Documentation

- [Tmux Configuration](tmux.md) - Terminal multiplexer (works great with vim-tmux-navigator)
- [Git Configuration](git.md) - Git tools that integrate with vim-fugitive
- [Bash Configuration](bash.md) - Shell configuration (sources vimwiki integration via `n` command)
- [Zsh Configuration](zsh.md) - Shell configuration (sources vimwiki integration via `n` command)

## Migration Notes

This configuration was modernized from a 6-year-old setup in October 2025:

**Removed** (7 plugins):
- `IndexedSearch` → Better alternatives in modern Vim
- `vim-extradite` → Abandoned, use `:Git log`
- `vim-multiple-cursors` → Archived, use visual block mode or macros
- `YankRing.vim` → Outdated, use registers and vim-peekaboo
- `ZoomWin` → Use `<C-w>_` and `<C-w>|` or splits
- `numbers.vim` → Archived, use `set relativenumber`
- Wrong EasyMotion repo → Fixed to correct repo

**Added** (10 plugins):
- `vim-sleuth` → Auto-detect indentation
- `vim-highlightedyank` → Visual feedback for yank
- `catppuccin` → Modern theme matching tmux
- `vim-vsnip` → Snippet engine (VSCode format)
- `vim-vsnip-integ` → Snippet integration with asyncomplete
- `friendly-snippets` → Community snippet collection
- `vim-which-key` → Keybinding helper showing available combinations
- `vimwiki` → Personal wiki for note-taking
- `vim-eunuch` → Unix shell commands (:Delete, :Move, :Rename, etc.)
- Corrected `easymotion` repo

**Enabled** (7 plugins previously unused):
- `vim-lsp` → LSP client
- `vim-lsp-settings` → Auto language server config
- `asyncomplete.vim` → Async completion framework
- `asyncomplete-lsp.vim` → LSP completion source
- `vim-vsnip` → Snippet engine
- `vim-vsnip-integ` → Snippet integration
- `friendly-snippets` → Community snippets

**Configured**:
- Full LSP setup (~120 lines) with key bindings for all 6 languages
- ALE configured to work alongside LSP (linting only, no LSP conflict)
- Language-specific settings for Python, Java, JavaScript/TypeScript, Scala, Shell, SQL
- Enhanced file type detection and navigation
- vim-vsnip snippet support with asyncomplete integration
- vim-which-key for keybinding discovery
- vimwiki for structured note-taking (integrated with shell `n` command)
- vim-eunuch for enhanced file operations
- Omni completion fallbacks for all supported languages
- NERDTree as primary file explorer (netrw disabled)

## Future Enhancements

Potential additions being considered:

- **Neovim config** (parallel setup): User plans to explore nvim for potential better feature set
- **More language servers**: As needed for additional languages
- **LLM-powered completion**: GitHub Copilot, Codeium, or TabNine for AI-assisted coding

## Resources

- [vim-lsp GitHub](https://github.com/prabirshrestha/vim-lsp) - LSP client documentation
- [vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) - Language server configs
- [Vim Help](https://vimhelp.org/) - Official Vim documentation
- [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/) - Vimscript guide

---

**Last Updated**: October 2025
**Maintainer**: Arun Karunagath
**GitHub**: [kra3/dot_files](https://github.com/kra3/dot_files)
