-- Keymaps are set based on which-key.
-- This can be generalized to remove the dependency, but not now.
local keymaps = {
  -- Global mappings.
  {
    mode = "n",
    {"<leader>e", "<cmd>Neotree<CR>", desc = "Open file explorer" },
    -- Tab navigation.
    {
      mode = {"n", "i"},
      group = "Tab navigation",
      {"<M-Tab>", "gt", desc = "Go to next tab"},
      {"<M-S-Tab>", "gT", desc = "Go to prev tab"},
    },
    -- Window navigation.
    {
      mode = {"n", "i"},
      group = "Window navigation",
      {"<M-h>",       "<cmd>wincmd h<CR>", desc = "Go to left window"},
      {"<M-j>",       "<cmd>wincmd j<CR>", desc = "Go to down window"},
      {"<M-k>",       "<cmd>wincmd k<CR>", desc = "Go to up window"},
      {"<M-l>",       "<cmd>wincmd l<CR>", desc = "Go to right window"},
      {"<M-s>",       "<cmd>wincmd s<CR>", desc = "Split horizontally"},
      {"<M-v>",       "<cmd>wincmd v<CR>", desc = "Split vertically"},
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

-- Grep.
local function get_grep_replace_pattern(grep, replace, confirm)
  local confirm_flag = confirm and "c" or "" 
  local separator = "/"
  local escaped_separator = "\\" .. separator
  local replace_pattern = separator .. table.concat(
    {grep:gsub(separator, escaped_separator), replace:gsub(separator, escaped_separator), "g" .. confirm_flag},
    separator
  )
  return replace_pattern
end

local function grep_replace_buf(grep, replace, confirm)
  local replace_pattern = get_grep_replace_pattern(grep, replace, confirm)
  vim.api.nvim_cmd({cmd = "s", args = {replace_pattern}, range = {0, vim.fn.line('$')}}, {})
end

local function grep_replace_global(grep, replace, confirm)
  local replace_pattern = get_grep_replace_pattern(grep, replace, confirm)
  -- Run :grep and then :cfdo %s
  vim.api.nvim_cmd({
    cmd = "grep",
    args = {grep},
    mods = {silent = true, emsg_silent = true}
  }, {})
  vim.api.nvim_cmd({
    cmd = "cfdo",
    args = {"%s", replace_pattern}
  }, {})
end

table.insert(
  keymaps,
  {
    mode = "n",
    {"<leader>G", group = "grep"},
    {
      "<leader>Gr",
      function()
        local grep;
        local replace;
        vim.ui.input({prompt="Grep: "}, function(input) grep = input end)
        vim.ui.input({prompt="Grep: " .. grep .. "\nReplace: "}, function(input) replace = input end)
        grep_replace_buf(grep, replace, true)
      end,
      desc="Grep and replace (buffer)",
    },
    {
      "<leader>GR",
      function()
        local grep;
        local replace;
        vim.ui.input({prompt="Grep: "}, function(input) grep = input end)
        vim.ui.input({prompt="Grep: " .. grep .. "\nReplace: "}, function(input) replace = input end)
        grep_replace_global(grep, replace, true)
      end,
      desc="Grep and replace (global)",
    },
  }
)

-- Telescope.
local ts_ok, ts = pcall(require, "telescope.builtin")
table.insert(
  keymaps,
  {
    mode = "n",
    cond = ts_ok,
    {"<leader><space>", function() ts.find_files() end, desc = "Find files"},
    {"<leader>/", function() ts.live_grep() end, desc = "Live grep" },
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
    {"<leader>ld", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, desc = "Toggle diagnostics"},
    {"<leader>lf", function() vim.diagnostic.open_float() end, desc = "Open diagnostics float"},
  }
)

-- Autocompletion
table.insert(
  keymaps,
  {
    mode = "i",
    {"<c-space>", function() vim.lsp.completion.get() end, desc = "Trigger autocomplete"},
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
      {"<leader>gt", "<cmd>Gitsigns toggle_signs<CR>",              desc = "Toggle git"},
      {"<leader>gR",
        function() 
          local confirmed = vim.fn.confirm("Reset buffer?", "&Yes\n&No", 0)
          if confirmed == 1 then
            gs.reset_buffer()
          else
            print("Cancelled")
          end
        end,
        desc = "Reset buffer"
      },
      {"<leader>gr", "<cmd>Gitsigns reset_hunk<CR>",                desc = "Reset hunk"},
      {"<leader>gb", function() gs.blame_line({ full = true }) end, desc = "Blame line"},
      {"<leader>gB", function() gs.blame() end,                     desc = "Blame"},
      {"<leader>gd", gs.diffthis,                                   desc = "Diff"},
    },
  }
)

require("which-key").add(keymaps)
