return {
  "hrsh7th/nvim-cmp",
  opts = {
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end
    },
    sources = {
      { name = 'nvim_lsp' },
    },
  }
}
