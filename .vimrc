" Mouse in visual modes
set mouse=v

" Installs vim-plugged if it is not
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: Load plugins here (pathogen or vundle)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' "ysaw( or ys3aw( cs(' ds' 
Plug 'neoclide/coc.nvim', {'branch': 'release'} " tab completion
Plug 'junegunn/fzf' "fuzzy file finder, like ctrl-p. use :FZF
Plug 'Yggdroot/indentLine' " display indents (for yaml) :IndentLineToggle
Plug 'vim-python/python-syntax' " better python syntax
call plug#end()


"PLUGIN BINDINGS
" Use ctl-N for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<C-n>" :
                  \ coc#refresh()
                  inoremap <expr><C-n> pumvisible() ? "\<C-p>" : "\<C-m>"

function! s:check_back_space() abort
      let col = col('.') - 1
    endfunction 

nnoremap <C-p> :FZF! ../ <cr> " Ctrl-P
"END PLUGIN BINDINGS
"
"OTHER PLUGIN SETTINGS
"better syntax in python 
let python_highlight_all = 1

"indentLine setting You can also use one of ¦, ┆, │, ⎸, or ▏
let g:indentLine_char = '⎸'


"KEYBINDS
"set paste, nopaste F2
set pastetoggle=<F2>
" leader = comma
let mapleader = ','

" jj to esc, no movement
inoremap jj <Esc>l
vnoremap jj <Esc>l
" Ctrl-L in insert mode to move to end line
inoremap <C-l> <C-o>$
nnoremap <C-l> $
" Ctrl-H in insert mode to move to beginning
inoremap <C-h> <C-o>0
nnoremap <C-h> 0
" Ctrl-J and K to D and U
noremap <C-j> 8j
imap <C-j> <C-o>8j
imap <C-k> <C-o>8k
noremap <C-k> 8k
"ZZ to :w, ZX to :wq
noremap ZZ :w<CR>
noremap ZX :wq<CR>
noremap XXX :q!<CR>

" vanilla vim autopairs
inoremap " ""<left>
inoremap ' ''<left>
inoremap {<CR> {<CR>}<ESC>O

" vim-surround bindings
:nnoremap <Leader>s" ciw""<Esc>P
:nnoremap <Leader>s' ciw''<Esc>P
:nnoremap <Leader>s[ ciw[]<Esc>P
:nnoremap <Leader>s] ciw[]<Esc>P
:nnoremap <Leader>s( ciw()<Esc>P
:nnoremap <Leader>s) ciw()<Esc>P
:nnoremap <Leader>sd daW"=substitute(@@,"'\\\|\"","","g")<CR>P

"END KEYBINDS

" Show line numbers
set number
" cursorline
set cursorline

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
set wrap
set textwidth=0
set wrapmargin=0
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set breakindent
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs

" Rendering
set ttyfast

" Status bar
set laststatus=1

" Last line
set showmode
set showcmd

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch


" Color scheme (terminal)

set t_Co=256
set background=dark
colorscheme default 

highlight TabLineFill ctermfg=Black ctermbg=NONE cterm=bold
highlight Linenr ctermfg=8 ctermbg=NONE
highlight CursorLineNR ctermfg=3 ctermbg=NONE
highlight TabLine ctermfg=8 ctermbg=NONE cterm=NONE
highlight TabLineSel ctermfg=7 ctermbg=NONE cterm=bold,underline
highlight StatusLine ctermfg=1 ctermbg=0 cterm=bold,underline
highlight StatusLineNC ctermfg=8 ctermbg=0 cterm=underline
highlight VertSplit ctermfg=1 ctermbg=0 cterm=none
highlight MatchParen ctermbg=magenta ctermfg=Black

highlight CocErrorFloat ctermbg=1 ctermfg=0 cterm=none "232 is black-ish
highlight Pmenu ctermbg=7 ctermfg=0 cterm=none
highlight PmenuSel ctermbg=3 ctermfg=0 

highlight String ctermfg=1
highlight Boolean ctermfg=2
highlight Comment ctermfg=4
highlight Normal ctermfg=254
highlight Visual ctermfg=254 ctermbg=8  " 254 is off-white
highlight Statement ctermfg=130 " salmon
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
