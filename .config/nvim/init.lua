----------------------------------------
-- install packer
----------------------------------------
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end vim.api.nvim_exec( [[ augroup Packer autocmd!  autocmd BufWritePost init.lua PackerCompile
    augroup end
    ]],
    false
)

local use = require("packer").use
require("packer").startup(function()
    use "wbthomason/packer.nvim"        -- packer manages itself

    use "tpope/vim-commentary"          -- gcc Vgc
    use "tpope/vim-surround"            -- cs\""
    use {
        "junegunn/fzf",                 -- fzf
        run = "fzf#install()"
    }
    use "junegunn/fzf.vim"              -- fzf vim integration
    use "wellle/targets.vim"            -- ci) cin( cin' di. dia dib
    use "lukas-reineke/indent-blankline.nvim" -- show tabs
    use "fatih/vim-go"
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
end)

local disabled_built_ins = {
    "getscript",
    "getscriptPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.g.netrw_banner = 0                      -- disable annoying banner
vim.g.netrw_altv = 1                        -- open splits to the right
vim.g.netrw_liststyle = 3                   -- tree view

vim.g.fzf_layout = { down = "~30%" }        -- open fzf below

vim.opt.list = false
----------------------------------------
-- rice
----------------------------------------
vim.opt.cursorline = true
vim.opt.number = true

----------------------------------------
-- sets
----------------------------------------
vim.opt.shadafile = "NONE"                  -- disable shada
vim.opt.number = true                       -- line nums
vim.opt.relativenumber = true

vim.opt.smartindent = true                  -- indent according to lang 

vim.opt.tabstop = 4                         -- 4 space tabs
vim.opt.softtabstop = 4                     -- backspace removes all spaces
vim.opt.shiftwidth = 4                      -- >> shifts by 4
vim.opt.expandtab = true                    -- insert tabs as spaces
vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.clipboard = "unnamedplus"           -- use system clipboard

vim.opt.ignorecase = true                   -- ignore case in searches
vim.opt.smartcase = true                    -- unless capital query

vim.opt.showmatch = true                    -- highlight matching brackets

vim.opt.path:append("**")                   -- enable fuzzy :find ing
vim.opt.guicursor = ""                      -- fixes alacritty changing cursor
vim.opt.signcolumn= "number"

vim.opt.completeopt = "menu,longest"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.virtualedit = "onemore"
vim.opt.backspace = "indent,eol,start"
vim.opt.laststatus = 1
vim.opt.path = ".,**"
vim.opt.wildmenu = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.mouse = "a"

-- better backups (~/.local/share/nvim/undo)
vim.opt.swapfile = false                    -- disable swapfiles
vim.opt.backup = false                      -- and auto backps, to instead use
vim.opt.undofile = true                     -- enable auto save of undos

vim.opt.updatetime = 250                    -- decrease update time

vim.opt.hidden = true                       -- dont save when switching buffers
vim.opt.inccommand = "nosplit"              -- incremental live completion
vim.opt.pastetoggle = "<F2>"

vim.opt.nrformats:append("alpha")       -- let <Ctrl-a> do letters as well
----------------------------------------
-- maps
----------------------------------------
-- local func to set keybinds
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type,key,value,{noremap = true, silent = true});
end
remap("n","gr", "gT")
remap("n","[<space>", ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>")
remap("n","]<space>", ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr><Esc>")
remap("n","n", "nzz")
remap("n", "N", "Nzz")
remap("i", "wq", "<esc>l")
remap("v", "wq", "<esc>l")
remap("i", "{<CR>", "{<CR>}<Esc>O")
remap("n", "Y", "y$")

-- git
remap("n", "<leader>gs", ":Git status<CR>")

-- neovim defaults that rock
remap("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>")

----------------------------------------
-- treesitter
----------------------------------------
require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "go",
        "python",
        "yaml",
        "lua",
        "c",
        "bash",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    }
}

----------------------------------------
-- colors
----------------------------------------
vim.cmd[[
hi Comment ctermfg=3
hi Conditional ctermfg=5
hi Constant ctermfg=2
hi CursorLine ctermbg=236 cterm=NONE
hi CursorLineNR ctermfg=15 ctermbg=236 cterm=NONE
hi Function ctermfg=2
hi Linenr ctermfg=246
hi Number ctermfg=2
hi Pmenu ctermbg=7 ctermfg=0
hi PmenuSel ctermbg=6 ctermfg=0
hi Number ctermfg=2
hi Repeat ctermfg=4
hi Conditional ctermfg=134
hi Special ctermfg=5
hi SpellBad ctermfg=NONE ctermbg=NONE cterm=underline
hi Statement ctermfg=6
hi StatusLine ctermbg=242 ctermfg=253 cterm=NONE
hi StatusLineNC ctermbg=236 ctermfg=253 cterm=NONE
hi String ctermfg=1
hi TabLine ctermfg=246 ctermbg=NONE cterm=NONE
hi TabLineFill ctermfg=0 ctermbg=NONE cterm=bold
hi TabLineSel ctermfg=253 ctermbg=NONE cterm=bold,underline
hi VertSplit ctermfg=5 ctermbg=0 cterm=NONE
hi Visual ctermfg=15 ctermbg=8
hi pythonStatement ctermfg=5 cterm=bold
hi shDerefSimple ctermfg=5
hi! link bashStatement Normal
hi! link pythonFunctionCall Function
hi! link pythonOperator Conditional
hi! link shCommandSub Normal
hi! link shOperator Normal
hi! link shStatement Normal
hi! link shVariable Normal
]]
