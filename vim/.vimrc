runtime! debian.vim

set backupdir=~/.vim/backup,/tmp
set wrapscan   		"continue searching at top when hitting bottom
set spell
set autoindent 		"automatically intend next line

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
"Bundle 'pope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'jmcantrell/vim-virtualenv'

" Bundle 'git://git.wincent.com/command-t.git'

syntax on

filetype on 
filetype plugin indent on

set fileformat=unix
au BufNewFile * set fileformat=unix

set background=dark
colorscheme solarized
set ruler 
set number

set tabstop=4
set shiftwidth=4
set softtabstop=4 
set expandtab
set smarttab
set autoindent
set smartindent

set nocompatible

set hlsearch  			"highlight search results
set incsearch 			"incremental search
set ignorecase 			"d
set smartcase 

set showcmd 			"always show the command
set showmatch 
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

set cursorline
set encoding=utf-8
set wildmenu

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Bundle 'scrooloose/syntastic'
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

