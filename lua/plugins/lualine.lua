return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- We only really care to update the line on events, not over time.
    refresh_time = 100,
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'filename'},
      lualine_c = {
          -- TODO: breadcrumbs
      },
      lualine_x = { 'searchcount', 'selectioncount' },
      lualine_y = {'location', '%LL', 'filesize'},
      lualine_z = {'filetype'},
    },
  }
}
