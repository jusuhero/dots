-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--Theme :
lvim.colorscheme = "nvimgelion"
lvim.transparent_window = true
lvim.plugins = {
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/nvim-nio",
  "norcalli/nvim-colorizer.lua",
  "nyngwang/nvimgelion",
  "Tsuzat/NeoSolarized.nvim",
  "folke/which-key.nvim",
  "linux-cultist/venv-selector.nvim",
}

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
  "css",
  "html",
  "typescript"
}

-- IDE Stuff
-- Hex value of colors show as color in vim
require("colorizer").setup()

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, { name = "prettier", args = { "--print-width", "100" }, filetypes = { "typescript", "typescriptreact", "tcss", "html" } } }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.lua" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", args = { "--ignore=E203" }, filetypes = { "python" } }, { name = "shellcheck", args = { "--severity", "warning" } } }

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- CSS LSP config - ignore unknown At rules
require("lvim.lsp.manager").setup("cssls", {
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  },
})

-- Which key setup (Shows a bar with possible commands after doing an action like y,d,v etc.)
vim.o.timeoutlen = 100 -- How long it takes for the bar to show after pressing the action
lvim.builtin.which_key.setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
  -- add operators that will trigger motion and text object completion
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't affect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>',   -- binding to scroll up inside the popup
  },
  window = {
    border = "single",        -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  timeout = true,
  timeoutlen = 100,
  -- triggers = {"<leader>"} -- or specify a list manually
}

-- Some cool which key mappings
local wk = require("which-key")
wk.register({
  f = {
    name = "file",                                                              -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" },                       -- create a binding with label
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
    n = { "New File" },                                                         -- just a label. don't create any mapping
    e = "Edit File",                                                            -- same as above
    ["1"] = "which_key_ignore",                                                 -- special label to hide it in the popup
  },
  c = {
    name = "Venv",
    v = { ":VenvSelect<CR>", "Select Python Virtual Environment", noremap = true }
  }
}, { prefix = "<leader>" })

-- venv-selector configuration
require('venv-selector').setup({
  search = true,
  search_path = { 'path/to/your/venvs' }, -- Specify your venv directories
  search_recursive = false,
  stay_on_this_version = true,
})

-- Optionally, you can map a key to open the venv selector
