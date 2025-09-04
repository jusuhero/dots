return {
  {
    "Koalhack/darcubox-nvim",
    config = function()
      require("darcubox").setup({
        options = {
          transparent = true,
          styles = {
            comments = { italic = true },
            functions = { bold = true },
            keywords = { italic = true },
            types = { italic = true, bold = true },
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darcubox",
    },
  },
}
