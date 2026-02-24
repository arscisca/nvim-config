return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
  },
  event = "VeryLazy",
  opts = {
    automatic_enable = true,
  }
}
