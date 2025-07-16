return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      nav = false,
      z = false,
      g = false,
    },
  },
  keys = {
    {"<leader>?", function() local wc = require("which-key").show({global = false}) end, desc = "Buffer keymappings"},
  },
}
