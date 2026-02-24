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
  c = {
      function_definition = "declarator",
      type_definition = "declarator",
      struct_specifier = "name",
      union_specifier = "name",
      preproc_function_def = "name",
      preproc_def = "name",
  }
}


local function collect_breadcrumbs(filter)
  -- Collect the breadcrumbs, starting from the current node and moving up.
  -- Whenever a node's type matches `filter`, store it as a breadcrumb.
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
  event = "UIEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      -- We only really care to update the line on events, not over time.
      refresh_time = 100,
      globalstatus = true,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'filename'},
      lualine_c = {
        -- Collect breadcrumbs with treesitter.
        function()
          local node_types_to_catch = nodes_by_language[vim.o.filetype] or nodes_by_language.general
          local breadcrumbs = collect_breadcrumbs(node_types_to_catch)
          local names = {}
          for _, breadcrumb in pairs(breadcrumbs) do
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
