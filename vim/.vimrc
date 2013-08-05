runtime! debian.vim

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" the package manager
Bundle 'gmarik/vundle'   

" Ctrlp search buffer, mru files, files
Bundle 'kien/ctrlp.vim'

" ack - the better grep
Bundle 'mileszs/ack.vim'                       

" ag - the better Ack
Bundle 'rking/ag.vim'                       

" claims to be faster and fully vimscript.
Bundle 'mbbill/undotree'     

" better taglist
Bundle 'majutsushi/tagbar'

" git support
Bundle 'tpope/vim-fugitive'                    

" moving around in the file
Bundle 'Lokaltog/vim-easymotion'  

" block navigation/creation
Bundle 'tpope/vim-surround'                    

" syntax checker
Bundle 'scrooloose/syntastic'                  

" show search item index
Bundle 'vim-scripts/IndexedSearch'

" useful for python
Bundle "michaeljsmith/vim-indent-object"

" seamless motion between tmux panes and vim panes
Bundle "christoomey/vim-tmux-navigator"

" repeat whole scommands in the plug-in mapping
Bundle 'tpope/vim-repeat'

" relative / Normal line numbering
Bundle "myusuf3/numbers.vim"

" Comments toggling - gcc 
Bundle 'tpope/vim-commentary'

" python virtual env support
Bundle 'jmcantrell/vim-virtualenv'             

" html zen edit
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}    

"Increments/decrements dates, time rather than treating them as numbers on
" <C-A> and <C-X> respectively
Bundle 'tpope/vim-speeddating'

" Three separate functions: coercion, substitution, & abbreviation
Bundle 'tpope/vim-abolish'

" Arrange code, eg., aligning '=' or ':' in a class/function 
Bundle 'godlygeek/tabular'

" awesome completion, but need a recent vim version
" Valloric/YouCompleteMe 

" moving in a line
" Bundle 'goldfeld/vim-seek'

" file browser - using CtrlP now   
"Bundle 'scrooloose/nerdtree'                    

" undo list
" Bundle 'sjl/gundo.vim'                         

" Color schemes: solarized, zenburn 
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnurmine/Zenburn'

set nocompatible
set encoding=utf-8
set shortmess+=I     		"remove message at startup
set t_Co=256

syntax on

" Enable filetype plugins
filetype on 
filetype plugin indent on

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
"let g:solarized_termcolors=256     " to use degraded color pallette if
"terminal is not using solorized color pallette
colorscheme solarized

set ruler "Always show current position 
set number

set tabstop=4
set softtabstop=4 
set shiftwidth=4
set expandtab " Use spaces instead of tabs
set smarttab

set spell
set spelllang=en

set autoindent 		    "automatically intend next line
set smartindent         "be smart while doing so 
set shiftround          

set hlsearch  			"highlight search results
set incsearch 			"incremental search
set ignorecase 			"do case insensitive matching
set smartcase           "do smart case matching
set wrapscan   		    "continue searching at top when hitting bottom

set showcmd 			" Show (partial) command in status line.
set showmatch           " Show matching brackets.
set mat=2               " How many tenths of a second to blink when matching brackets
set showmode

set complete+=k    " default is ".,w,b,u,t,i"
set completeopt+=longest
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set history=50
set undolevels=100

set lazyredraw   " don't redraw while executing macros

" To scroll in the terminul
"set mouse=a

" Show special characters
"if v:version >= 700
"  set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"else
"  set list listchars=tab:>-,trail:.,extends:>
"endif

map ; :

" Don't break up long lines, but visually wrap them.
set textwidth=0
set wrap

set scrolloff=5      " Minimal number of screen lines to keep above and below the cursor.

set autoread                    " Automatically read new changes to a file
"set autowrite
set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column
set wildmenu                    " command line completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set wildignorecase   " When set case is ignored when completing file names and directories.
set wildignore+=*.swp,*.bak,*.pyc,*.class,.git,.hg
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " images
set wildignore+=*.o,*.exe,*.dll,*.manifest " compiled object files

" A buffer becomes hidden when it is abandoned, & buffer switching w/o saving
set hidden

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Sets <Leader> - \ is the default, but I used to forget; poor memory ;)
let mapleader = ","
let g:mapleader = ","

" index ctags from any project
map <Leader>ct :!ctags -R .<CR>
set tags=./tags;/    " look for tags from current dir to upwards

" More natural split opening
"set splitbelow
"set splitright

imap <C-w> <C-o><C-w>

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" numbers.vim
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" Undo list
nnoremap <F5> :UndotreeToggle<CR>

if has("persistent_undo")
    set undodir = "~/.vim/undofiles"
    set undofile
endif

" treat long lines as break lines = easier navigation
map j gj
map k gk

map <silent> <leader><cr> :noh<cr> " Disable highlight when <leader><cr> is pressed
"map <leader>ba :1,1000 bd!<cr> " Close all the buffers
map <leader>cd :cd %:p:h<cr>:pwd<cr> " Switch CWD to the directory of the open buffer

" Easier split window navigation
nnoremap <C-Down>   <C-W>j
nnoremap <C-Up>     <C-W>k
nnoremap <C-Left>   <C-W>h
nnoremap <C-Right>  <C-W>l

" vim-tmux-navigatior conflict with my default Ctrl+hjkl commands, I'm
" redefining the bindings to keep consistent key bindings with tmux and vim.
nnoremap <leader>j      <C-w>j
nnoremap <leader>k      <C-w>k
nnoremap <leader>h      <C-w>h
nnoremap <leader>l      <C-w>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Fugitive tricks
" to go to parent tree while in :Gedit
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" delete :Gedit buffers when moving to another object
autocmd BufReadPost fugitive://* set bufhidden=delete
" Show git branch in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gp :Git push<cr>
nnoremap <Leader>gr :Gremove<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>

" Move a line of text using ALT+[jk]
nnoremap <silent> <C-S-j> :move .-2<CR>|
nnoremap <silent> <C-S-k> :move .+1<CR>|
vnoremap <silent> <C-S-j> :move '<-2<CR>gv|
vnoremap <silent> <C-S-k> :move '>+1<CR>gv|
inoremap <silent> <C-S-k> <C-o>:move .+1<CR>|
inoremap <silent> <C-S-j> <C-o>:move .-2<CR>|

" Toggle between paste mode
nnoremap <silent> <Leader>p :set paste!<cr>

map <leader>ss :setlocal spell!<cr> " Pressing ,ss will toggle and untoggle spell checking

map <leader>sn ]s       " Next spell error
map <leader>sp [s       " Prev spell error
map <leader>sa zg       " Add word to dictionary
map <leader>s? z=       " Correct given word to <from list>

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

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,split           " newtab - instead of split open a new tab page for quickfix
  set stal=1   " showtabline       2 - always, 1 - more than 1, 0 - never 
catch
endtry

" I'm using Ctrl-P now {{{
    " open nerdTree with Ctrl + n
    " map <C-n> :NERDTreeToggle<CR>
    " Open nerdTree automatically at startup if no file is specified
    "autocmd vimenter * if !argc() | NERDTree | endif
    " Close vim if NerdTree is the only window open
    "atocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    "let NERDTreeWinSize = 20
    "let NERDTreeChDirMode=2  " use the new dir as cwd
" }}}

" Tagbar settings.
nnoremap <silent> <F8> :TagbarToggle<CR>

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['+', '-']

" Bundld 'scrooloose/syntastic'
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1

" Configure vim's builtin netrw file browser - it can work across various
" protocols. So read the docs.
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_preview=1
let g:netrw_winsize=20
map <C-n> :Ve<CR>     " Open a Vertical split at current files path

" For ctrlp
" let g:ctrlp_cmd = 'CtrlP' " set to CtrlPMixed to search all at once
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_show_hidden = 0
let g:ctrlp_max_files = 0 " No upper limit
let g:ctrlp_extensions = ['quickfix', 'changes', 'line', 'undo']

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Ctrl-r: Easier search and replace
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" Ctrl-s: Easier substitue
vnoremap <c-s> :s/\%V//g<left><left><left>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Fast saving
nmap <leader>w :w!<cr>

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
"if exists('$TMUX')
"  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif

" Open ranger to choose file, map it to ,r
" Install `ranger` on your system first, It's a curl based file manager.
" I can live with NerdTree rather than have to ever open ranger, but just in
" case
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map ,r :call RangerChooser()<CR>

