runtime! debian.vim

set backupdir=~/.vim/backup,/tmp
set wrapscan   		"continue searching at top when hitting bottom
set spell
set autoindent 		"automatically intend next line

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

syntax on

filetype on 
filetype plugin indent on

set fileformat=unix
au BufNewFile * set fileformat=unix

colorscheme zenburn
set background=dark
set ruler 
set number

set tabstop=4
set shiftwidth=4
set softtabstop=4 
set expandtab
set smarttab
set autoindent
set smartindent
set shiftround

set nocompatible

set hlsearch  			"highlight search results
set incsearch 			"incremental search
set ignorecase 			"do case insensitive matching
set smartcase           "do smart case matching

set showcmd 			" Show (partial) command in status line.
set showmatch           " Show matching brackets.
set mat=5
set showmode

map ;  :

set shortmess+=I     		"remove message at startup
set complete+=k
set completeopt+=longest
set backspace=indent,eol,start
set history=50

" Show special characters
"if v:version >= 700
"  set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"else
"  set list listchars=tab:>-,trail:.,extends:>
"endif

" Don't break up long lines, but visually wrap them.
set textwidth=0
set wrap

set cursorline                  " Highlight current line
set cursorcolumn                " Highlight current column
set encoding=utf-8
set wildmenu
set autoread                    " Automatically read new changes to a file

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

nnoremap <F5> :GundoToggle<CR>

"open nerdTree with Ctrl + n
map <C-n> :NERDTreeToggle<CR>
"open nerdTree automatically on vim startup
"autocmd vimenter * NERDTree
"Open nerdTree automatically at startup if no file is specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if NerdTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Bundld 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
 
" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Open ranger to choose file, map it to ,r
fun! RangerChooser()
    exec "silent !ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map ,r :call RangerChooser()<CR>

