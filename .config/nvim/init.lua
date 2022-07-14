-- env
vim.env.FZF_DEFAULT_COMMAND = 'find .'

-- bootstrap packer
----------------------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command 'packadd packer.nvim'
end

-- don't throw error on first packer use
local ok, packer = pcall(require, "packer")
if not ok then return end

require("packer").startup(function()
    use "wbthomason/packer.nvim"        -- packer manages itself

    use "tpope/vim-commentary"          -- gcc Vgc
    use "tpope/vim-surround"            -- cs\""
    use "ggandor/leap.nvim"             -- s\w\w
    use "akinsho/toggleterm.nvim"
    use "junegunn/fzf"                  -- fzf
    use "junegunn/fzf.vim"              -- fzf vim integration
    use "wellle/targets.vim"            -- ci) cin( cin' di. dia dib
    use "lukas-reineke/indent-blankline.nvim" -- show tabs
    use { "fatih/vim-go", ft='go' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }
    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after='nvim-treesitter'
    }
    if packer_bootstrap then
        require('packer').sync()
    end
end)
if packer_bootstrap then
    return
end
-- vim settings
----------------------------------------
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false                      -- and auto backps, to instead use
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"           -- use system clipboard
vim.opt.completeopt = "menuone"
vim.opt.cursorline = true
vim.opt.expandtab = true                    -- insert tabs as spaces
vim.opt.guicursor = ""                      -- fixes alacritty changing cursor
vim.opt.hidden = true                       -- dont save when switching buffers
vim.opt.hlsearch = true
vim.opt.ignorecase = true                   -- ignore case in searches
vim.opt.inccommand = "split"              -- incremental live completion
vim.opt.incsearch = true
vim.opt.laststatus = 1
vim.opt.list = true
vim.opt.listchars:append("trail:·")
vim.opt.mouse = "a"
vim.opt.nrformats:append("alpha")           -- let Ctrl-a do letters as well
vim.opt.number = true
vim.opt.pastetoggle = "<F2>"
vim.opt.path:append("**")                   -- enable fuzzy :find ing
vim.opt.relativenumber = true
vim.opt.shadafile = "NONE"                  -- disable shada
vim.opt.shiftwidth = 0                      -- >> shifts by tabstop
vim.opt.showmatch = true                    -- highlight matching brackets
vim.opt.signcolumn= "number"
vim.opt.smartcase = true                    -- unless capital query
vim.opt.smartindent = true                  -- indent according to lang
vim.opt.softtabstop = -1                     -- backspace removes tabstop
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false                    -- disable swapfiles
vim.opt.tabstop = 4                         -- 4 space tabs
vim.opt.undofile = true                     -- enable auto save of undos
vim.opt.updatetime = 250                    -- decrease update time
vim.opt.virtualedit = "onemore"
vim.opt.wildmenu = true

vim.g.netrw_banner = 0                      -- disable annoying banner
vim.g.netrw_altv = 1                        -- open splits to the right
vim.g.netrw_liststyle = 3                   -- tree view
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
vim.g.indent_blankline_use_treesitter = true


-- mappings
----------------------------------------
-- local func to set keybinds
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type,key,value,{noremap = true, silent = true});
end
remap("i", "wq", "<esc>l")
remap("i", "{<CR>", "{<CR>}<Esc>O")
remap("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>")
remap("n", "N", "Nzz")
remap("n", "Y", "y$")
remap("n","[<space>", ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>")
remap("n","]<space>", ":<c-u>put =repeat([''],v:count)<bar>'[-1<cr><Esc>")
remap("n","gr", "gT")
remap("n","n", "nzz")
remap("t", "wq", "<C-\\><C-n>")
remap("v", "wq", "<esc>l")
remap("n", "<leader>b", ":Buffers<CR>")
remap("n", "<leader>f", ":Files<CR>")
remap("n", "<leader>l", ":Lines<CR>")
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- autocmd
----------------------------------------
local undopath = "~/.local/share/nvim/undo"
vim.api.nvim_create_autocmd("VimEnter", {
    command = "silent !mkdir -p " .. undopath,
    group = vim.api.nvim_create_augroup("Init", {}),
})

local toggle_rel_num = vim.api.nvim_create_augroup("ToggleRelNum", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    command = "set norelativenumber",
    group = toggle_rel_num,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    command = "set relativenumber",
    group = toggle_rel_num,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", {}),
})

-- include
----------------------------------------
require('plugins')
