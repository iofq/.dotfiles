if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' "yss( ysiw( cs(' ds'
Plug 'tpope/vim-commentary' "gcc Vgc
Plug 'wellle/targets.vim' " ci) cin( cin' di. dia dib
Plug 'Yggdroot/indentLine' " display indents :IndentLineToggle
Plug 'iofq/py.vim'
call plug#end()

let mapleader=" "
let g:netrw_banner=0

set pastetoggle=<F2>
inoremap wq <Esc>l:w<CR>
vnoremap wq <Esc>l:w<CR>

nnoremap gr gT
nnoremap <Leader><Leader> <C-w>

inoremap {<cr> {<cr>}<Esc>O
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr><Esc>

set completeopt=menu,longest
inoremap <expr> <Tab> TabComplete()
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
fun! TabComplete()
    if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
        return "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType python,c,go,bash autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
autocmd FileType python compiler pylint
autocmd FileType python,c setlocal ts=4 sts=4 sw=4 " whitespace

set hidden
set number relativenumber
set syntax=on
set showmatch
set cursorline
set splitbelow splitright
set visualbell t_vb=

set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set smartindent autoindent breakindent
set virtualedit=onemore

set backspace=indent,eol,start

set ttyfast
set laststatus=1
set wildmenu

set path=.,**
set incsearch hlsearch
set ignorecase

set noswapfile nobackup
set undofile undodir=~/.vim/undodir
set clipboard=unnamedplus

set ttymouse=sgr "fix scrolling in st
set mouse=a
set t_Co=256
colorscheme py

set nocompatible
