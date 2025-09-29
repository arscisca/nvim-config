return {
  'everviolet/nvim', name = 'evergarden',
  priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  opts = {
    theme = {
      variant = 'winter', -- 'winter'|'fall'|'spring'|'summer'
      accent = 'red',
    },
    editor = {
      transparent_background = false,
      float = {
        color = 'mantle',
        solid_border = false,
      },
      completion = {
        color = 'surface0',
      },
    },
  }
}
