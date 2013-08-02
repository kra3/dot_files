runtime! debian.vim

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" the package manager
Bundle 'gmarik/vundle'   

" moving around in the file
Bundle 'Lokaltog/vim-easymotion'  

" html zen edit
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}    

" syntax checker
Bundle 'scrooloose/syntastic'                  

" undo list
Bundle 'sjl/gundo.vim'                         

" block navigation/creation
Bundle 'tpope/vim-surround'                    

" file browser   
Bundle 'scrooloose/nerdtree'                    

" git support
Bundle 'tpope/vim-fugitive'                    

" python virtual env support
Bundle 'jmcantrell/vim-virtualenv'             

" ack - the better grep
Bundle 'mileszs/ack.vim'                       

" code browsing
Bundle 'taglist.vim'                           

"Buffer explorer
Bundle 'fholgado/minibufexpl.vim'

" Color schemes: solarized, zenburn & molokai/monokai
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnurmine/Zenburn'
Bundle 'tomasr/molokai'

" Bundle 'git://git.wincent.com/command-t.git'

set nocompatible
set encoding=utf-8
set shortmess+=I     		"remove message at startup
set t_Co=256

syntax on

" Enable filetype plugins
filetype on 
filetype plugin indent on

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

set autoindent 		"automatically intend next line
set smartindent
set shiftround

set hlsearch  			"highlight search results
set incsearch 			"incremental search
set ignorecase 			"do case insensitive matching
set smartcase           "do smart case matching
set wrapscan   		"continue searching at top when hitting bottom

set showcmd 			" Show (partial) command in status line.
set showmatch           " Show matching brackets.
set mat=2
set showmode

map ; :

set complete+=k
set completeopt+=longest
set backspace=indent,eol,start
set history=50
set undolevels=500

" Show special characters
"if v:version >= 700
"  set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"else
"  set list listchars=tab:>-,trail:.,extends:>
"endif

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

set complete=.,w,t
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

" EasyMotion
let g:EasyMotion_leader_key = ';'

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" index ctags from any project
map <Leader>ct :!ctags -R .<CR>

" More natural split opening
"set splitbelow
"set splitright

imap <C-w> <C-o><C-w>

" MiniBuffer Mappings
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Undo list
nnoremap <F5> :GundoToggle<CR>

" Easier split window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" open nerdTree with Ctrl + n
map <C-n> :NERDTreeToggle<CR>
" open nerdTree automatically on vim startup
" autocmd vimenter * NERDTree
" Open nerdTree automatically at startup if no file is specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if NerdTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeWinSize = 20

" Taglist settings.
nnoremap <silent> <F8> :TlistToggle<CR>

let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1

" Bundld 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
 
" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" Fast saving
nmap <leader>w :w!<cr>

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

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects
"       .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

