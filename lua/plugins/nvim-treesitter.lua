return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    additional_vim_regex_highlighting = false,
  }
}
