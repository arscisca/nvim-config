-- Keymaps are set based on which-key.
-- This can be generalized to remove the dependency, but not now.
local keymaps = {
  -- Global mappings.
  {
    mode = "n",
    {"<leader>e", "<cmd>Neotree<CR>", desc = "Open file explorer" },
    -- Window / tab cycling.
    {"<Tab>",     "<cmd>wincmd w<CR>", desc = "Cycle window"},
    {"<S-Tab>",   "<cmd>wincmd W<CR>", desc = "Inv-cycle window"},
    {"<M-Tab>",   "<cmd>gt<CR>", desc = "Cycle tab"},
    {"<S-M-Tab>", "<cmd>gT<CR>", desc = "Inv-cycle tab"},
    -- Window navigation.
    {
      mode = {"n", "i"},
      {"M-h",       "<cmd>wincmd h<CR>", desc = "Go to left window"},
      {"M-j",       "<cmd>wincmd j<CR>", desc = "Go to down window"},
      {"M-k",       "<cmd>wincmd k<CR>", desc = "Go to up window"},
      {"M-l",       "<cmd>wincmd l<CR>", desc = "Go to right window"},
    },
  },
  -- Markers.
  {
    mode = "n",
    {"<leader>m", group = "Markers"},
    {"<leader>mt", "<cmd>MarksToggleSigns<CR>", desc = "Toggle mark signs"},
    {"<leader>ma", "<cmd>MarksListAll<CR>", desc = "List all marks"},
    {"<leader>mb", "<cmd>MarksListAll<CR>", desc = "List buf marks"},
    {"<leader>mB", "<cmd>delmarks!<CR>", desc = "Delete buf marks"},
  },
}

-- Telescope.
local ts_ok, ts = pcall(require, "telescope.builtin")
table.insert(
  keymaps,
  {
    mode = "n",
    cond = ts_ok,
    {"<leader><space>", function() ts.find_files() end, desc = "Find files"},
    {"<leader>/", function() ts.live_grep({grep_open_files=true}) end, desc = "Live grep" },
    {"<leader>*", function() ts.grep_string() end, mode = {"n", "v"}, desc="Grep cursor/selection"},

    {"<leader>t", group = "Telescope"},
    {"<leader>to", function() ts.live_grep({grep_open_files=true}) end, desc = "Live grep open files" },
    {
      "<leader>tG",
      function() 
        vim.ui.input({ prompt = "Path: ", completion="file_in_path"},
          function(input)
            ts.live_grep({search_dirs={input}}) 
          end
        )
      end,
      desc = "Live grep in path"
    },
  }
)

-- LSP.
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
table.insert(
  keymaps,
  {
    mode = "n",
    {"<leader>l", group = "LSP"},
    {"<leader>lt", function() toggle_lsp_in_buf(vim.api.nvim_get_current_buf()) end, desc = "Toggle LSP in buffer"},
    {"<leader>ldt", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, desc = "Toggle diagnostics"},
  }
)


-- Gitsigns.
local gs_ok, gs = pcall(require, "gitsigns")
table.insert(
  keymaps,
  {
    mode = "n",
    cond = gs_ok,
    {
      "]h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end,
      desc = "Next hunk"
    },
    {
      "[h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, 
      desc = "Prev hunk"
    },
    {
      mode = {"n", "v"},
      {"<leader>g",  group = "Git"},
      {"<leader>gt", "<cmd>Gitsigns toggle_signs<CR>",                               desc = "Toggle git"},
      {"<leader>gR", gs.reset_buffer,                                                desc = "Reset"},
      {"<leader>gr", "<cmd>Gitsigns reset_hunk<CR>",                                 desc = "Reset hunk"},
      {"<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line"},
      {"<leader>gB", function() gs.blame() end,                                      desc = "Blame"},
      {"<leader>gd", gs.diffthis,                                                    desc = "Diff"},
    },
  }
)

require("which-key").add(keymaps)
