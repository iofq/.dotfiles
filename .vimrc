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
call plug#end()

let mapleader=" "
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
autocmd FileType text setlocal spell spelllang=en_us spellcapcheck= " [s and ]s, z=

filetype plugin indent on
set completeopt=menu,longest
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

autocmd Syntax python syn match pythonFunctionCall "\zs\w*\ze("
colorscheme zellner
hi Comment ctermfg=45
hi Conditional ctermfg=134
hi CursorLine ctermbg=236 cterm=NONE
hi CursorLineNR ctermfg=15 ctermbg=236 cterm=NONE
hi Function ctermfg=75
hi Linenr ctermfg=246
hi Number ctermfg=178
hi Repeat ctermfg=71
hi SpellBad ctermfg=NONE ctermbg=NONE cterm=underline
hi Statement ctermfg=75
hi StatusLine ctermbg=242 ctermfg=253 cterm=NONE
hi StatusLineNC ctermbg=236 ctermfg=253 cterm=NONE
hi String ctermfg=130
hi TabLine ctermfg=246 ctermbg=NONE cterm=NONE
hi TabLineFill ctermfg=0 ctermbg=NONE cterm=bold
hi TabLineSel ctermfg=253 ctermbg=NONE cterm=bold,underline
hi VertSplit ctermfg=75 ctermbg=0 cterm=NONE
hi Visual ctermfg=15 ctermbg=8
hi pythonStatement ctermfg=75 cterm=bold
hi shDerefSimple ctermfg=75
hi! link bashStatement Normal
hi! link pythonFunctionCall Function
hi! link pythonOperator Conditional
hi! link shCommandSub Normal
hi! link shOperator Normal
hi! link shStatement Normal
hi! link shVariable Normal
