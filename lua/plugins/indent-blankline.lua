local file_small_enough = function(buf)
    local fname = vim.api.nvim_buf_get_name(buf)
    local fsize = vim.fn.getfsize(fname)
    local maxsize = 1024 * 1024  -- 1 MiB
    return fsize < maxsize
end


return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  init = function()
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.ACTIVE, file_small_enough)
  end,
  opts = {
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = {
      show_start = false,
      show_end = false,
      char = "▍",
    },
    exclude = {
      filetypes = {
        "''",
        "text",
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "dashboard",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
      }
    },
  },
}
