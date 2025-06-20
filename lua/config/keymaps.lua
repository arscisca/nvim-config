-- Global mappings.
vim.keymap.set('n', '<leader>e', ':Neotree<CR>', { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader><space>', ':Telescope fd<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<CR>', { desc = 'Live grep' })

-- Plugin specific mappings, loaded dynamically.
local function keymap_gitsigns(buffer)
  local gs = require('gitsigns')

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {buffer = buffer, desc = desc })
  end

  map(
    "n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end,
    "Next change"
  )

  -- Go to previous hunk.
  map(
    "n", "[c", function()
       if vim.wo.diff then
         vim.cmd.normal({ "[c", bang = true })
       else
         gs.nav_hunk("prev")
       end
    end, 
    "Prev change"
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
