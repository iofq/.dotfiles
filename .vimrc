" Installs vim-plugged if it is not
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Load plugins here (pathogen or vundle)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' "yss( ysiw( cs(' ds' 
Plug 'Yggdroot/indentLine' " display indents (for yaml) :IndentLineToggle
call plug#end()

" KEYBINDS
" leader = comma
let mapleader=" "
"set paste, nopaste F2
set pastetoggle=<F2>
"autocomplete 
inoremap <C-f> <C-x><C-f>
" easy Esc
inoremap wq <Esc>l:w<CR>
tnoremap wq <C-w>:q!<CR>
vnoremap wq <Esc>l:w<CR>
noremap XXX :qa!<CR>

" leader pane movement
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0

nnoremap <Leader>te :tabe<CR>:Explore<space>
nnoremap <Leader>tt :tabe<CR>

" vanilla vim autopairs
inoremap {<CR> {<CR>}<ESC>O
" Visual shifting (not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" insert return in normal mode
nnoremap <CR> i<CR><Esc>

" netrw binds
map <Leader>e :Explore<space>
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

map <Leader><CR> :term<CR>
noremap Y y$

" python
autocmd FileType python nnoremap <Leader>tr :tab term python -i %<CR>
autocmd FileType python compiler pylint
"END KEYBINDS

"indentLine setting You can also use one of ¦, ┆, │, ⎸, or ▏
let g:indentLine_char = '⎸'

" method folding (za)
set foldmethod=indent
set foldlevel=99

" Show line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" cursorline
set cursorline

" netrw configs
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1

" Show file stats
set ruler
" Turn on syntax highlighting
syntax on

" Blink cursor on error instead of beeping
set visualbell
set t_vb=

" Encoding
set encoding=utf-8

" Whitespace
set nowrap
set textwidth=0
set wrapmargin=0
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set breakindent
set smartindent
set noshiftround
set virtualedit=onemore

" whitespace for python 
autocmd FileType python setlocal ts=4 sts=4 sw=4

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

" Rendering
set ttyfast

" Status bar
set laststatus=1

set wildmenu
set path+=**

" Last line
set showmode
set showcmd

" Searching
set incsearch
set nohlsearch
set ignorecase
set smartcase
set showmatch

" fuck swapfiles
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" use system clipboard
set clipboard=unnamedplus

" fix scrolling
set ttymouse=sgr
set mouse=a

" Color scheme (terminal)
set t_Co=256
set background=dark
colorscheme default 

highlight TabLineFill ctermfg=Black ctermbg=NONE cterm=bold
highlight Linenr ctermfg=8 ctermbg=NONE
highlight CursorLineNR ctermfg=0 ctermbg=8 cterm=none
highlight TabLine ctermfg=8 ctermbg=NONE cterm=NONE
highlight TabLineSel ctermfg=253 ctermbg=NONE cterm=bold,underline
highlight StatusLine ctermfg=5 ctermbg=0 cterm=underline
highlight StatusLineNC ctermfg=8 ctermbg=0 cterm=underline
highlight VertSplit ctermfg=5 ctermbg=0 cterm=none
highlight MatchParen ctermbg=magenta ctermfg=Black
highlight Folded ctermfg=0 ctermbg=7 cterm=none
highlight EndOfBuffer ctermfg=black ctermbg=black
highlight CocErrorFloat ctermbg=1 ctermfg=0 cterm=none "232 is black-ish
highlight Pmenu ctermbg=7 ctermfg=0 cterm=none
highlight PmenuSel ctermbg=3 ctermfg=0 

highlight String ctermfg=1
highlight Boolean ctermfg=2
highlight Comment ctermfg=4
highlight Normal ctermfg=254
highlight Visual ctermfg=254 ctermbg=8  " 254 is off-white
highlight Statement ctermfg=130 "salmon
highlight Conditional ctermfg=2
highlight Constant ctermfg=1
highlight Operator ctermfg=5
highlight Define ctermfg=2
highlight Function ctermfg=6
highlight Structure ctermfg=2
highlight Special ctermfg=3
highlight Identifier ctermfg=7

" Open new split panes to right and bottom
set splitbelow
set splitright

set nocompatible
