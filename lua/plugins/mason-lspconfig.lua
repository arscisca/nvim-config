return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  opts = {
    ensure_installed = { "lua_ls", "rust_analyzer" },
    automatic_enable = true,
  },
}
