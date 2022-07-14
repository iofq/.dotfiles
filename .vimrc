let g:netrw_banner=0
let g:netrw_liststyle=3

set pastetoggle=<F2>
inoremap wq <Esc>l
vnoremap wq <Esc>l
nnoremap gr gT
inoremap {<cr> {<cr>}<Esc>O
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr><Esc>
nnoremap n nzz
nnoremap N Nzz

autocmd FileType yaml,dockerfile setlocal ts=2 sts=2 sw=2

filetype plugin indent on
set completeopt=menu
set number cursorline
set syntax=on showmatch
set splitbelow splitright
set visualbell t_vb=

set ts=4 sw=4 sts=4 expandtab
set autoindent breakindent
set virtualedit=onemore
set backspace=indent,eol,start

set laststatus=1
set path=.,** wildmenu
set incsearch hlsearch smartcase

set noswapfile nobackup undofile undodir=~/.vim/undodir
set clipboard=unnamedplus
set mouse=a
set t_Co=256

colorscheme zellner
