local make_mapping = function()
  local cmp = require("cmp")
  return {
    -- Arrow keys do nothing.
    ["<Up>"] = function(fallback)
      fallback()
    end,
    ["<Down>"] = function(fallback)
      fallback()
    end,
    -- Alt-arrow select entries.
    ["<M-Up>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<M-Down>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    -- Enter confirms the (explicitly) selected entry
    ["<CR>"] = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end,
    -- Shift-enter confirms the (implicitly) selected entry.
    ["<S-CR>"] = function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end,
    -- Tab confirms entry.
    ["<Tab>"] = function(fallback)
      if cmp.visible() and cmp.get_selected_entry() ~= nil then
        cmp.confirm({ select = true })
      else
        fallback()
      end
    end,
  }
end

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    enabled = function()
      -- Don't suggest anything while in comments, strings or numeric literals
      local ctx = require("cmp.config.context")
      return not ctx.in_treesitter_capture("comment")
        and not ctx.in_treesitter_capture("string")
        and not ctx.in_treesitter_capture("number")
    end,
    mapping = make_mapping(),
    matching = {
      disallow_fuzzy_matching = false,
      disallow_fullfuzzy_matching = false,
      disallow_partial_matching = false,
    },
    experimental = {
      ghost_text = false
    },
    sources = {
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, _)
          local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
          return kind ~= 'Text' and kind ~= 'Keyword'
        end
      },
    },
  },
}
