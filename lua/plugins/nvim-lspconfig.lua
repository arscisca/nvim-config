
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  config = function()
    vim.diagnostic.config({
      underline = false,
      virtual_text = true,
      virtual_lines = false,
      float = {},
      signs = false,
    })
  end,
  opts = {
  },
}
