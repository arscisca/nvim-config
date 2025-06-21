local nodes_by_language = {
  general = {
      function_definition = "name",
      function_declaration = "name",
      method_definition = "name",
      class_definition = "name",
  },
  rust = {
      mod_item = "name",
      trait_item = "name",
      function_item = "name",
      impl_item = "type",
      struct_item = "name",
  },
}


local function breadcrumbs(filter)
  local node = vim.treesitter.get_node()
  local breadcrumbs = {}
  while node do
    if filter[node:type()] then
        table.insert(breadcrumbs, node)
    end
    node = node:parent()
  end
  return breadcrumbs
end


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
        -- Collect breadcrumbs with treesitter.
        function()
          local node_types_to_catch = nodes_by_language[vim.o.filetype] or nodes_by_language.general
          local breadcrumbs = breadcrumbs(node_types_to_catch)
          local names = {}
          for i, breadcrumb in pairs(breadcrumbs) do
            local field = node_types_to_catch[breadcrumb:type()]
            local name = breadcrumb:field(field)[1]
            local text = vim.treesitter.get_node_text(name, 0) or breadcrumb:type()
            table.insert(names, 1, text)
          end
          return table.concat(names, ".")
        end
      },
      lualine_x = { 'searchcount', 'selectioncount' },
      lualine_y = {'location', '%LL', 'filesize'},
      lualine_z = {'filetype'},
    },
  }
}
