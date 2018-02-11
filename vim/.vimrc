set nocompatible

" ===> Plugins - vim-plug  {{{

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'  " a replacement matcher.
Plug 'DavidEGx/ctrlp-smarttabs'

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ludovicchabant/vim-gutentags', { 'on': 'TagbarToggle' }

Plug 'mileszs/ack.vim'

Plug 'junegunn/vim-peekaboo'  " see registers
Plug 'vim-scripts/YankRing.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-rhubarb'

Plug 'jiangmiao/auto-pairs'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'

Plug 'scrooloose/syntastic'
" switch to ale
" Plug 'w0rp/ale.git'

Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'vim-scripts/IndexedSearch'

Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'Yggdroot/indentLine'  " evaluate against above

Plug 'christoomey/vim-tmux-navigator'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'

" Buffers list - Sure minibuffer explorer is ultimate
" Plug 'bling/vim-bufferline'
" Plug 'fholgado/minibufexpl.vim'

Plug 'vim-scripts/ZoomWin'
Plug 'schickling/vim-bufonly'
Plug 'gioele/vim-autoswap'
Plug 'moll/vim-bbye'

" Plug 'bronson/vim-trailing-whitespace'. " remove custom trailing function

Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-rooter'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --all
  endif
endfunction
Plug 'Valloric/YouCompleteMe',  { 'do': function('BuildYCM') }

" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" file browser - using CtrlP now
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind'] }
  \ | Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'mattn/emmet-vim'

" Plug 'vim-scripts/TaskList.vim'
" Plug 'wesQ3/vim-windowswap'

" How about some repel - 'conque', may be later?
" Plug 'jpalardy/vim-slime'

" session management - misc is a dependency
" Plug 'xolox/vim-session'
" Plug 'xolox/vim-misc'
" try this as well
Plug 'tpope/vim-obsession'

" Projects - needs to configure the projects inside the vimrc
" Plug 'amiorin/vim-project'

" Plug 'vimwiki/vimwiki'
" Plug 'MattesGroeger/vim-bookmarks'
"Plug 'dr-chip-vim-scripts/ZoomWin', { 'on': 'ZoomWin' }

" Python mode  (A lot of features for python
" support: pylint, rope, pep8, pyflakes, pydoc, mccabe, virtualenv
" Plug 'klen/python-mode'

" Try this: better folding for python
" Plug 'tmhedberg/SimpylFold'
" And this one for pep 8 confirmant intends
" Plug 'vim-scripts/indentpython.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'justinmk/vim-gtfo'
Plug 'editorconfig/editorconfig-vim'

" Color schemes: solarized, dracula, onedark
Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
  \ | Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'sheerun/vim-polyglot'

" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'othree/jsdoc-syntax.vim', { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'othree/jspc.vim', { 'for': 'javascript' }
" Plug '1995eaton/vim-better-javascript-completion', { 'for': 'javascript' }

" Haskell specific
" Plug 'dag/vim2hs'
" Plug 'lukerandall/haskellmode-vim'

call plug#end()

" }}}

" ===> General Configurations {{{

" look & feel
" set shortmess+=I     		" remove message at startup
set background=dark
colorscheme onedark

set number              " show line numbers
set numberwidth=3       " number of columns for line numbers
set textwidth=0         " Do n:ot wrap words (insert)
set nowrap              " Do not wrap words (view)
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set noshowmode          " airline takes care of modes, so no need to display them again
set colorcolumn=80      " ideal max text width (increase to 120?)
set showtabline=0       " show tab line when there are at least 2 tabs

" Turn on cursor line & column line only on active window
augroup MyAutoCmd
  autocmd WinLeave * setlocal nocursorline
  autocmd WinLeave * setlocal nocursorcolumn
  autocmd WinEnter,BufRead * setlocal cursorline
  autocmd WinEnter,BufRead * setlocal cursorcolumn
augroup END

" enable spell check in English
set spell
set spelllang=en

" More natural split opening
set splitbelow
set splitright

set switchbuf=useopen,usetab,split
set hidden              " enable multiple modified buffers

set modelines=1         " allow vim specific commands to be given at the end of file.
set lazyredraw          " don't redraw while executing macros

" line endings - LF
set fileformat=unix
au BufNewFile * set fileformat=unix

" spacing and intending
set tabstop=4           " A tab is 8 spaces by default
set softtabstop=4       " Insert 4 spaces when a Tab is pressed
set shiftwidth=4        " An indent is 4 spaces
set shiftround          " Round spaces to nearest shiftwidth multiple
set expandtab           " Use spaces instead of tabs
set nojoinspaces        " Don't convert spaces to tabs
set smartindent         " be smart while intending

" searching
set hlsearch  			    " highlight search results
set ignorecase 			    " do case insensitive matching by default
set smartcase           " don't ignore if pattern contains CAPS
set wrapscan   	        " continue searching at top when hitting bottom

" set backup off, most of my work is with version controlled files
set nobackup
set noswapfile
if has("persistent_undo")
  silent !mkdir -vp ~/.backup/vim/undo/ > /dev/null 2>&1
  set backupdir=~/.backup/vim,.       " list of directories for the backup file
  set directory=~/.backup/vim,~/tmp,. " list of directory names for the swap file
  set undofile
  set undodir=~/.backup/vim/undo/,~/tmp,.
endif

" completion
" set path+=**
set completeopt=menuone,preview,longest   " insert mode completion
set wildmode=list:longest,list:full       " with wild menu (using \t)
set wildignorecase
set wildignore+=*.a,*.o,*.exe,*.dll,*.manifest
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.jpeg
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp,*.bak,*.pyc,*.class
set wildignore+=*/tmp/*,*.so,*.zip

"folding
if has("folding")
  set foldcolumn=0      " columns for folding
  set foldmethod=indent
  set foldlevel=9
  set nofoldenable      " don't fold by default
endif

set tags=./tags;/    " look for tags from current dir to upwards
" index ctags from any project
noremap <Leader>ct :!ctags -R .<CR>

" Remember last position (of edit) in a file
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set clipboard=unnamed  "use system register *, not register "

" }}}

" ===> Keybindings {{{

noremap ; :             " convenience for US keyboard
" Sets <Leader> - \ is the default, but I used to forget; poor memory ;)
" let g:mapleader = ","
let mapleader = "\<Space>"
" let maplocalleader = "\<Space>"

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Fast saving
nnoremap <leader>w :w!<cr>

" in the spirit of vim-unimpaired
nnoremap [om  <Esc>:set mouse=a<CR>  " enable mouse for scrolling
nnoremap ]om  <Esc>:set mouse=<CR>   " disable mouse

nnoremap <leader>s+ zg       " Add word to dictionary
nnoremap <leader>s? z=       " Correct given word to <from list>
nnoremap <leader>f  za       " Fold/UnFold a fold

" http://vim.wikia.com/wiki/VimTip738
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
" fix meta-keys which generate <Esc>a .. <Esc>z
" let c='a'
" while c <= 'z'
"   exec "set <M-".toupper(c).">=\e".c
"   exec "imap \e".c." <M-".toupper(c).">"
"   let c = nr2char(1+char2nr(c))
" endw

" treat long lines as break lines = easier navigation
noremap j gj
noremap k gk

inoremap <C-w> <C-o><C-w>

" " Easier search and replace
" vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" " Easier substitute
" vnoremap <c-s> :s/\%V//g<left><left><left>

" " Enable omni completion
" augroup MyAutoCmd
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"   autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"   " autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
" augroup END

" " To save, ctrl-s. Terminals may freeze, ctrl+q to rescue
" nnoremap <c-s> :w<CR>
" inoremap <c-s> <Esc>:w<CR>a

noremap <silent> <leader><cr> :noh<cr> " Disable highlight when <leader><cr> is pressed

" "map <leader>ba :1,1000 bd!<cr> " Close all the buffers
" noremap <leader>cd :cd %:p:h<cr>:pwd<cr> " Switch CWD to the directory of the open buffer

" " Easier split window navigation
" nnoremap <C-Down>   <C-W>j
" nnoremap <C-Up>     <C-W>k
" nnoremap <C-Left>   <C-W>h
" nnoremap <C-Right>  <C-W>l

" " vim-tmux-navigatior conflict with my default Ctrl+hjkl commands, I'm
" " redefining the bindings to keep consistent key bindings with tmux and vim.
" nnoremap <leader>j  <C-w>j
" nnoremap <leader>k  <C-w>k
" nnoremap <leader>h  <C-w>h
" nnoremap <leader>l  <C-w>l

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


" Toggle between paste mode
"nnoremap <silent> <Leader>p :set paste!<cr>
" set pastetoggle=<F2>     " both F2 and <leader>p does same thing now. Probably I'll remap above to CtrlP

" }}}

"  ===> Plugin Configurations  {{{

" numbers.vim
" nnoremap <F3> :NumbersToggle<CR>
" nnoremap <F4> :NumbersOnOff<CR>

" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" " Javascript
" let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" let g:syntastic_javascript_checkers = ['eslint']
"
" since yankstack uses c-n remaps that to c-d as in sublime
" let g:multi_cursor_next_key='<C-d>'

" CtrlP {{{
    let g:ctrlp_map = '<Leader>/'
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    let g:ctrlp_cmd = 'CtrlPLastMode'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_follow_symlinks = 1
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_max_files = 0 " No upper
    let g:ctrlp_extensions = ['buffertag', 'tag', 'quickfix', 'changes', 'smarttabs']

    if executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'  " --hidden
    endif
" }}}

" Tagbar  {{{
    nnoremap <Leader>m :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
    " let g:tagbar_autoclose = 1
    let g:tagbar_singleclick = 1
" }}}

" YankRing  {{{
    nnoremap <Leader>y :YRShow<CR>
" }}}

" Undo Tree  {{{
    nnoremap <Leader>u :UndotreeToggle<CR>
" }}}

" EasyMotion {{{
    " let g:EasyMotion_smartcase = 1
    " let g:EasyMotion_smartsign_us = 1
    " nmap <Leader><Leader> <Plug>(easymotion-s2)
    " nmap <Leader>/ <Plug>(easymotion-sn)
" }}}

" Indent guids {{{
" let g:indent_guides_guide_size=1
" let g:indent_guides_start_level=2
" }}}

" Fugitive {{{
    " " to go to parent tree while in :Gedit
    " autocmd User fugitive
    "     \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    "     \   nnoremap <buffer> .. :edit %:h<CR> |
    "     \ endif
    " " delete :Gedit buffers when moving to another object
    " autocmd BufReadPost fugitive://* set bufhidden=delete

    " nnoremap <Leader>gb :Gblame<cr>
    " nnoremap <Leader>gc :Gcommit<cr>
    " nnoremap <Leader>gd :Gdiff<cr>
    " nnoremap <Leader>gp :Git push<cr>
    " nnoremap <Leader>gr :Gremove<cr>
    " nnoremap <Leader>gs :Gstatus<cr>
    " nnoremap <Leader>gw :Gwrite<cr>
" }}}

" {{{ Vim signify
    let g:signify_vcs_list = [ 'git' ]
    let g:signify_mapping_next_hunk = '<leader>sj'
    let g:signify_mapping_prev_hunk = '<leader>sk'
    let g:signify_mapping_toggle_highlight = '<leader>sh'
    let g:signify_mapping_toggle = '<leader>st'
" }}}

" Airline {{{
    let g:airline#extensions#virtualenv#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_exclude_preview = 1  " for ctrlspace
" }}}

" vim-bufferline {{{
"   let g:bufferline_echo = 0
" }}}

" netrw - in-built file-browser in vim {{{
    " " It can work across various protocols. So read the docs.
    " let g:netrw_liststyle=3  " use tree layout
    " let g:netrw_banner = 0  " do not display info on the top of window
    " let g:netrw_sort_sequence = '[\/]$,*'  " dir first, files second.

    " " make it behave like NERDTree
    " " let g:netrw_browse_split=4  " where to open. 4: previous, 0: same buffer
    " " let g:netrw_preview=1  " use vertical preview window
    " " let g:netrw_altv = 1  " split at right.
    " " let g:netrw_winsize=20  " split at right.
    " " noremap <C-l> :Le<CR> " if not above.Open a Vertical split at current files path

    " " open tree in same buffer.
    " " let g:netrw_browse_split=0  " where to open. 4: previous, 0: same buffer
    " nnoremap  <leader>e :Explore<CR> " Open tree at current path
" }}}

" NERDTree {{{
    " open nerdTree with Leader + n
    noremap <Leader>n :NERDTreeToggle<CR>

    " Open nerdTree automatically at startup if no file is specified
    " autocmd vimenter * if !argc() | NERDTree ~/src | endif

    " Close vim if NerdTree is the only window open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    let NERDTreeWinSize = 25
    let NERDTreeChDirMode=2  " use the new dir as cwd
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.orig$', '\.rej$', '\~$']
" }}}

" Syntastic {{{
    " let g:syntastic_enable_signs = 1
    " " let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1
    " let g:syntastic_error_symbol='✗'
    " let g:syntastic_warning_symbol='⚠'
    " let g:syntastic_always_populate_loc_list=1
    " let g:syntastic_loc_list_height=5
    " let g:syntastic_check_on_wq = 0
    " let g:syntastic_python_checkers=['flake8']  " add 'pep8', 'pyflakes', 'pylint' too, if you need more checks
" }}}

" Ack / Ag {{{
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor  " Use Ag over Grep
    let g:ackprg = 'ag --vimgrep'  " use Ag with Ack.vim
    cnoreabbrev Ack Ack!
    nnoremap <Leader>a :Ack!<Space>
endif
" }}}

" UltiSnips {{{
    " Remap Ultisnips completer triggers to make YouCompleteMe happy :) & Me
    " function! g:UltiSnips_Complete()
    "     call UltiSnips_ExpandSnippet()
    "     if g:ulti_expand_res == 0
    "         if pumvisible()
    "             return "\<C-n>"
    "         else
    "             call UltiSnips_JumpForwards()
    "             if g:ulti_jump_forwards_res == 0
    "                return "\<TAB>"
    "             endif
    "         endif
    "     endif
    "     return ""
    " endfunction

    " " au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

    " let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-ultisnips-snippets"]
    " let g:UltiSnipsExpandTrigger="<C-e>"
    " let g:UltiSnipsJumpForwardTrigger="<C-e>"
    " let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" }}}

" Slime - REPEL {{{
" let g:slime_target = "tmux"
" " let g:slime_paste_file = tempname()
" let g:slime_python_ipython = 1  " use ipython's %cpaste
" }}}

" }}}

" ===> Custom Functions {{{

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()

" {{{ save & restore folds on exit/enter  + a nice fold line
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()
" }}}

" Ranger integration {{{
" " Install `ranger` on your system first, It's a ncurses based file manager.
" fun! RangerChooser()
"     exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
"     if filereadable('/tmp/chosenfile')
"         exec 'edit ' . system('cat /tmp/chosenfile')
"         call system('rm /tmp/chosenfile')
"     endif
"     redraw!
" endfun
" noremap ,r :call RangerChooser()<CR>
" }}}

" }}}

" ===> Overrides  {{{

" global override - for system specific overrides - eg: work, personal
try
  source ~/.vimrc.local
catch
endtry

" load custom .vim files in the directories - for project specific configs.
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif
" }}}

" vim: set foldmethod=marker foldlevel=0 nomodeline:
