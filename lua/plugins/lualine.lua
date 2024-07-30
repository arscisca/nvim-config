return {
  "nvim-lualine/lualine.nvim",
  opts = {
    theme = "gruvbox",
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "filename", path = 1 } },
      lualine_c = { [[TODO breadcrumbs]] },
      lualine_x = { "branch" },
      lualine_y = {
        "filetype",
        {
          "%L",
          fmt = function(str)
            return string.format("%s L", str)
          end,
        },
        {
          function()
            local prefixes = { "", "k", "M", "G", "T", "P" }
            local bytes = vim.fn.wordcount().bytes
            local i = 1
            while bytes > 1000.0 and i < #prefixes - 1 do
              i = i + 1
              bytes = bytes / 1000.0
            end
            return string.format("%.2f %sB", bytes, prefixes[i])
          end,
        },
      },
      lualine_z = { "location" },
    },
    inactive = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
  enabled = true,
}
