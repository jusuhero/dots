return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      -- This function builds the plugin via the neovim function
      vim.fn["mkdp#util#install"]()
    end,
  },
}
