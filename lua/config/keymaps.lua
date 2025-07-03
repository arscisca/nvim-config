-- Global mappings.
vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>', { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope fd<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })

-- LSP
local detached_lsp_clients = {}
function toggle_lsp_in_buf(buf)
  -- If there are clients disabled for this current buffer, we need to a
  if detached_lsp_clients[buf] then
    for _, client_id in pairs(detached_lsp_clients[buf]) do
      vim.lsp.buf_attach_client(buf, client_id)
    end
    detached_lsp_clients[buf] = nil
  else
    detached_lsp_clients[buf] = {}
    local attached_clients = vim.lsp.get_clients({bufnr=buf})
    for _, client in pairs(attached_clients) do
      vim.lsp.buf_detach_client(buf, client.id)
      table.insert(detached_lsp_clients[buf], client.id)
    end
  end
end

vim.keymap.set('n', '<leader>lt', function() toggle_lsp_in_buf(vim.api.nvim_get_current_buf()) end, { desc = 'Toggle LSP in buffer' }) 
vim.keymap.set('n', '<leader>ldt', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = 'Toggle diagnostics' })

-- Plugin specific mappings, loaded dynamically.
local function keymap_gitsigns(buffer)
  local gs = require('gitsigns')

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {buffer = buffer, desc = desc })
  end

  map(
    "n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end,
    "Next hunk"
  )

  -- Go to previous hunk.
  map(
    "n", "[h", function()
       if vim.wo.diff then
         vim.cmd.normal({ "[c", bang = true })
       else
         gs.nav_hunk("prev")
       end
    end, 
    "Prev hunk"
  )

  map("n",          "<leader>gt",  ":Gitsigns toggle_signs<CR>", "Toggle git")
  map("n",          "<leader>gR",  gs.reset_buffer, "Reset")
  map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
  map("n",          "<leader>gB", function() gs.blame() end, "Blame")
  map("n",          "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
  map("n",          "<leader>gd", gs.diffthis, "Diff")
end

return {
  gitsigns = keymap_gitsigns,
}
