return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  opts = {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = { },
    keywordStyle = { italic = false, bold = true },
    statementStyle = { bold = true },
    stringStyle = { italic = true },
    typeStyle = { italic = false },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local palette = colors.palette
      return {
        WinSeparator = { fg = palette.dragonWhite },
        String = { italic = true },
        MarkSignHL = { fg = palette.roninYellow },
      }
    end,
    transparent = false,
    dimInactive = false,
    terminalColors = false,
  }
}
