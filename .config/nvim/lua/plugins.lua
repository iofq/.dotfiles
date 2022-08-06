-- treesitter
----------------------------------------
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "bash",
        "c",
        "dockerfile",
        "go",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "yaml", },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ac'] = '@comment.outer',
                ['ic'] = '@comment.inner',
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@call.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']]'] = '@function.outer',
                [']m'] = '@class.outer',
            },
            goto_next_end = {
                [']['] = '@function.outer',
                [']M'] = '@class.outer',
            },
            goto_previous_start = {
                ['[['] = '@function.outer',
                ['[m'] = '@class.outer',
            },
            goto_previous_end = {
                ['[]'] = '@function.outer',
                ['[M'] = '@class.outer',
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
}

-- leap
----------------------------------------
local leap = require('leap')
leap.set_default_keymaps()
leap.init_highlight(true)
vim.cmd([[ hi LeapLabelPrimary ctermbg=251 ctermfg=0 ]])

-- toggleterm
----------------------------------------
require("toggleterm").setup{
    open_mapping = [[<leader>t]],
    shade_terminals = true,
    size = vim.o.lines * 0.4
}

-- blankline
----------------------------------------
vim.cmd([[ hi IndentBlanklineChar ctermfg=240 ]])
vim.cmd([[ hi IndentBlanklineContextChar ctermfg=7 ]])
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}