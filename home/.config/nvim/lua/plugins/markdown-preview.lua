return {
  -- add gruvbox
  { "iamcco/markdown-preview.nvim" },

  -- Configure LazyVim to load gruvbox

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview" },
    build = "cd app && yarn install", -- Wenn du yarn/npm verwendest
    ft = { "markdown" },
    exec = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
