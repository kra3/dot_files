runtime! debian.vim

set nocompatible
filetype off  "required

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" the package manager
Bundle 'gmarik/Vundle.vim'

" Ctrlp search buffer, mru files, files
Bundle 'ctrlpvim/ctrlp.vim'
" Bundle 'FelikZ/ctrlp-py-matcher'  " a replacement matcher.
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
Bundle 'DavidEGx/ctrlp-smarttabs'

" ack - the better grep
" Bundle 'mileszs/ack.vim'

" ag - the better Ack
Bundle 'rking/ag.vim'
" Bundle 'gabesoft/vim-ags'  " another one. their edit mode is cool.

" claims to be faster and fully vimscript.<F5>
Bundle 'mbbill/undotree'

" better taglist <F8>
Bundle 'majutsushi/tagbar'

" git support
Bundle 'tpope/vim-fugitive'
Bundle 'int3/vim-extradite'

" mercurial (hg) support
Bundle 'ludovicchabant/vim-lawrencium'

" Never lose a yank/cut again
Bundle 'vim-scripts/YankRing.vim'

" moving around in the file. ,,w
Bundle 'Lokaltog/vim-easymotion'

" block navigation/creation. cs"' cst" ds" ysiw] yss) VS<p>
Bundle 'tpope/vim-surround'

" syntax checker
Bundle 'scrooloose/syntastic'

" show search item index
Bundle 'vim-scripts/IndexedSearch'

" useful for python. ai ii
Bundle "michaeljsmith/vim-indent-object"

" Visual indentations. ,ig
Bundle 'nathanaelkane/vim-indent-guides'

" seamless motion between tmux panes and vim panes
Bundle "christoomey/vim-tmux-navigator"

" Lots of bindings for [ & ] very useful
Bundle 'tpope/vim-unimpaired'

" repeat whole commands in the plug-in mapping
Bundle 'tpope/vim-repeat'

" relative / Normal line numbering <F3> <F4>
Bundle "myusuf3/numbers.vim"

" Comments toggling - gcc
Bundle 'tpope/vim-commentary'

" python virtual env support
Bundle 'jmcantrell/vim-virtualenv'

"Increments/decrements dates, time rather than treating them as numbers on
" <C-A> and <C-X> respectively
Bundle 'tpope/vim-speeddating'

" Three separate functions: coercion, substitution, & abbreviation
" :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
" :%Subvert/facilit{y,ies}/building{,s}/g
" snake_case:crs MixedCase: crm camelCase:crc UPPER CASE:cru
Bundle 'tpope/vim-abolish'

" Arrange code, eg., aligning '=' or ':' in a class/function
" :Tab /=  :Tab /=\zs :Tab /,/r0
Bundle 'godlygeek/tabular'

" Powerline
" fonts are here https://github.com/powerline/fonts
" Bundle 'powerline/powerline'

" Air-line
Bundle 'bling/vim-airline'

" Buffers list - Sure minibuffer explorer is ultimate
" Bundle 'bling/vim-bufferline'
" Bundle 'fholgado/minibufexpl.vim'

" awesome completion, but need a recent vim version
Bundle 'Valloric/YouCompleteMe'

" Show VCS changes right in your vim's sign gutter
Bundle 'mhinz/vim-signify'

" Snippets - I never used textmate, so that style doesn't matter to me :P
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'

" file browser - using CtrlP now
Bundle 'scrooloose/nerdtree'

" high speed html editing: <c-y>,
Bundle 'mattn/emmet-vim'

" undo list
" Bundle 'sjl/gundo.vim'

" TaskList ,td
Bundle 'vim-scripts/TaskList.vim'

" Swap split windows. ,ww 
Bundle 'wesQ3/vim-windowswap'

" Make current buffer full-screen and otherwise: <C-w> o
Bundle 'vim-scripts/ZoomWin'

" like sublime's ctrl+d. This one uses ctrl+d
Bundle 'terryma/vim-multiple-cursors'

" How about some repel - 'conque', may be later?
Bundle 'jpalardy/vim-slime'

" session management - misc is a dependency
Bundle 'xolox/vim-session'
Bundle 'xolox/vim-misc'

" try this as well
" Bundle 'tpope/vim-obsession'

" Projects - needs to configure the projects inside the vimrc
" Bundle 'amiorin/vim-project'

" spent time and configure this instead of vim-session and vim-project
" Bundle 'szw/vim-ctrlspace'

" Python mode  (A lot of features for python
" support: pylint, rope, pep8, pyflakes, pydoc, mccabe, virtualenv
" Bundle 'klen/python-mode'

" Try this: better folding for python
" Bundle 'tmhedberg/SimpylFold'
 
" Color schemes: solarized, zenburn
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnurmine/Zenburn'
Bundle 'sjl/badwolf'
" dim everything but focused block
Bundle 'junegunn/limelight.vim'

" Haskell specific
" Bundle 'dag/vim2hs'
" Bundle 'lukerandall/haskellmode-vim'

call vundle#end()

" Enable filetype plugins
filetype on
filetype plugin indent on

set encoding=utf-8
set shortmess+=I     		"remove message at startup
set t_Co=256
syntax on

try
  source ~/.vimrc.local
catch
endtry

set fileformat=unix
au BufNewFile * set fileformat=unix

" set backup off, most of my work is with version controlled files
set nobackup
set nowb
set noswapfile

set background=dark
" for badwolf color scheme
let g:badwolf_darkgutter = 1
let g:badwolf_tabline = 2
"let g:solarized_termcolors=256     " to use degraded color pallette if
"terminal is not using solorized color pallette
colorscheme badwolf
" colorscheme solarized

set ruler "Always show current position
set number

set tabstop=4           "A tab is 8 spaces
set softtabstop=4       "Insert 4 spaces when a Tab is pressed
set shiftwidth=4        "An indent is 4 spaces
set shiftround          "Round spaces to nearest shiftwidth multiple
set expandtab           "Use spaces instead of tabs
set smarttab            "Indent instead of tab at start of line
set nojoinspaces        "Don't convert spaces to tabs

set spell
set spelllang=en

set autoindent 		    "automatically intend next line
set smartindent         "be smart while doing so

set hlsearch  			"highlight search results
set incsearch 			"incremental search
set ignorecase 			"do case insensitive matching
set smartcase           "do smart case matching
set wrapscan   		    "continue searching at top when hitting bottom

set showcmd 			" Show (partial) command in status line.
set showmatch           " Show matching brackets.
set mat=2               " How many tenths of a second to blink when matching brackets
set noshowmode          " airline takes care of modes, so no need to display them again
set laststatus=2        " Always show status line - and pep it with airline ;)
" Show git branch in status line
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set ttimeoutlen=10
set modelines=1  " allow vim specific commands to be given at the end of file.

set complete+=k    " default is ".,w,b,u,t,i"
set completeopt+=longest
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set history=50
set undolevels=100

set lazyredraw   " don't redraw while executing macros

" To scroll in the terminal
"set mouse=a

" Show special characters (⤶ ‽ ˑ ·)
" set list    " on it with [ol - thnx to vim-unimpired
if v:version >= 700
  set listchars=tab:→\ ,trail:ˑ,nbsp:ˑ,eol:⤶,extends:>
else
  set listchars=tab:>-,trail:.,extends:>
endif

" To highlight whitespace
"highlight WhiteSpaces ctermbg=green guibg=#55aa55
"match WhiteSpaces /\s\+$/

" Don't break up long lines, but visually wrap them.
set textwidth=0
set wrap

set clipboard=unnamed  "use system register *, not register "

set scrolloff=5      " Minimal number of screen lines to keep above and below the cursor.
set sidescrolloff=7
set sidescroll=1

set autoread                    " Automatically read new changes to a file
" set autowrite
set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column
set colorcolumn=80              " ideal max text width
set wildmenu                    " command line completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set wildignorecase   " When set case is ignored when completing file names and directories.
set wildignore+=*.swp,*.bak,*.pyc,*.class,.git,.hg
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " images
set wildignore+=*.o,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*/tmp/* " on windows use *\\tmp\\*
"folding settings
set foldmethod=indent   "fold based on indent
set foldlevel=3
set foldclose=all

" A buffer becomes hidden when it is abandoned, & buffer switching w/o saving
set hidden

" More natural split opening
set splitbelow
set splitright

noremap ; :

" Sets <Leader> - \ is the default, but I used to forget; poor memory ;)
let mapleader = ","
let g:mapleader = ","

" http://vim.wikia.com/wiki/VimTip738
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
" fix meta-keys which generate <Esc>a .. <Esc>z
let c='a'
while c <= 'z'
  exec "set <M-".toupper(c).">=\e".c
  exec "imap \e".c." <M-".toupper(c).">"
  let c = nr2char(1+char2nr(c))
endw

" treat long lines as break lines = easier navigation
noremap j gj
noremap k gk

inoremap <C-w> <C-o><C-w>

" Enable omni completion
augroup MyAutoCmd
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  " autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
augroup END

" Turn on cursorline only on active window
augroup MyAutoCmd
  autocmd WinLeave * setlocal nocursorline
  autocmd WinEnter,BufRead * setlocal cursorline
augroup END

" Toggle between paste mode
"nnoremap <silent> <Leader>p :set paste!<cr>
set pastetoggle=<F2>     " both F2 and <leader>p does same thing now. Probably I'll remap above to CtrlP

" numbers.vim
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Undo list
nnoremap <F5> :UndotreeToggle<CR>

" since yankstack uses c-n remaps that to c-d as in sublime
let g:multi_cursor_next_key='<C-d>'

" Tagbar settings.
nnoremap <silent> <F8> :TagbarToggle<CR>

let g:tagbar_autofocus = 1
" let g:tagbar_autoclose = 1
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['+', '-']

" index ctags from any project
noremap <Leader>ct :!ctags -R .<CR>
set tags=./tags;/    " look for tags from current dir to upwards

" easymotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_smartsign_us = 1
nmap <Space> <Plug>(easymotion-s2)
nmap <Leader>/ <Plug>(easymotion-sn)

" To save, ctrl-s. Terminals may freeze, ctrl+q to rescue
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>a

if has("persistent_undo")
    set undodir = "~/.vim/undofiles"
    set undofile
endif

noremap <silent> <leader><cr> :noh<cr> " Disable highlight when <leader><cr> is pressed
"map <leader>ba :1,1000 bd!<cr> " Close all the buffers
noremap <leader>cd :cd %:p:h<cr>:pwd<cr> " Switch CWD to the directory of the open buffer

" Easier split window navigation
nnoremap <C-Down>   <C-W>j
nnoremap <C-Up>     <C-W>k
nnoremap <C-Left>   <C-W>h
nnoremap <C-Right>  <C-W>l

" vim-tmux-navigatior conflict with my default Ctrl+hjkl commands, I'm
" redefining the bindings to keep consistent key bindings with tmux and vim.
nnoremap <leader>j  <C-w>j
nnoremap <leader>k  <C-w>k
nnoremap <leader>h  <C-w>h
nnoremap <leader>l  <C-w>l

" Useful mappings for managing tabs
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Fugitive tricks
" to go to parent tree while in :Gedit
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" delete :Gedit buffers when moving to another object
autocmd BufReadPost fugitive://* set bufhidden=delete

nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gp :Git push<cr>
nnoremap <Leader>gr :Gremove<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>

" {{{ Vim signyfy
    let g:signify_mapping_next_hunk = '<leader>gj'
    let g:signify_mapping_prev_hunk = '<leader>gk'
    let g:signify_mapping_toggle_highlight = '<leader>gh'
    let g:signify_mapping_toggle = '<leader>gt'
" }}}

nnoremap <leader>s+ zg       " Add word to dictionary
nnoremap <leader>s? z=       " Correct given word to <from list>
nnoremap <leader>f  za       " Fold/UnFold a fold

map <leader>td <Plug>TaskList

" in the spirit of vim-unimpaired
nnoremap [om  <Esc>:set mouse=a<CR>  " enable mouse for scrolling
nnoremap ]om  <Esc>:set mouse=<CR>   " disable mouse

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,split           " newtab - instead of split open a new tab page for quickfix
  set stal=1   " showtabline       2 - always, 1 - more than 1, 0 - never
catch
endtry

" Airline
let g:airline#extensions#virtualenv#enabled = 1

" following will use powerline fonts to poulate airline_symbols dict
" "let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
" let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" A corresponding file is in virtualenv directory to handle django
if filereadable($VIRTUAL_ENV . '/.vimrc')
   source $VIRTUAL_ENV/.vimrc
endif

" vim-bufferline
" let g:bufferline_echo = 0

" Configure vim's builtin netrw file browser {{{
    " It can work across various protocols. So read the docs.
    let g:netrw_liststyle=3  " use tree layout
    let g:netrw_banner = 0  " do not display info on the top of window
    let g:netrw_sort_sequence = '[\/]$,*'  " dir first, files second.

    " make it behave like NERDTree
    " let g:netrw_browse_split=4  " where to open. 4: previous, 0: same buffer
    " let g:netrw_preview=1  " use vertical preview window
    " let g:netrw_altv = 1  " split at right.
    " let g:netrw_winsize=20  " split at right.
    " noremap <C-l> :Le<CR> " if not above.Open a Vertical split at current files path

    " open tree in same buffer.
    " let g:netrw_browse_split=0  " where to open. 4: previous, 0: same buffer
    nnoremap  <leader>e :Explore<CR> " Open tree at current path 
" }}}

" I'm using Ctrl-P now {{{
    " open nerdTree with Leader + n
    noremap <Leader>n :NERDTreeToggle<CR>
    " Open nerdTree automatically at startup if no file is specified
    autocmd vimenter * if !argc() | NERDTree ~/src | endif
    " Close vim if NerdTree is the only window open
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    let NERDTreeWinSize = 25
    let NERDTreeChDirMode=2  " use the new dir as cwd
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.orig$', '\.rej$', '\~$']
" }}}

" Bundld 'scrooloose/syntastic'
let g:syntastic_enable_signs = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']  " add 'pep8', 'pyflakes', 'pylint' too, if you need more checks

" For ctrlp
let g:ctrlp_map = '<Leader>/'
let g:ctrlp_cmd = 'CtrlPMixed' " set to CtrlPLastMode to open last used mode
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_show_hidden = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0 " No upper limit
let g:ctrlp_extensions = ['buffertag', 'tag', 'quickfix', 'changes', 'smarttabs']

" explore tags in whole project/tagfile.
nnoremap <Leader>t/   :CtrlPTag<CR>  
" explore tags in current buffer.
nnoremap <Leader>b/   :CtrlPBufTag<CR> 
" tab list
nnoremap <Leader>tl   :CtrlPSmartTabs<CR> 

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'  " --hidden

    " open ag
    nnoremap <leader>a :Ag
endif

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

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

" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-ultisnips-snippets"]
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2

" Ctrl-r: Easier search and replace
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" Ctrl-s: Easier substitue
vnoremap <c-s> :s/\%V//g<left><left><left>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Fast saving
nnoremap <leader>w :w!<cr>

"{{{ save & restore folds on exit/enter  + a nice fold line
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

" Open ranger to choose file, map it to ,r
" Install `ranger` on your system first, It's a ncurses based file manager.
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
noremap ,r :call RangerChooser()<CR>

" REPEL
let g:slime_target = "tmux"
" let g:slime_paste_file = tempname()
let g:slime_python_ipython = 1  " use ipython's %cpaste

" Session Management
let g:session_autoload = 'yes'  " load default session on load 
let g:session_autosave = 'yes'  " save state on quit
let g:session_default_to_last = 1  " open last session instead of default
let g:session_command_aliases = 1  " use Session* commands instead of *Session


" vim:foldmethod=marker:foldlevel=0
