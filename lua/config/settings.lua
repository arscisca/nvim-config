-- Formatting
vim.g.autoformat = false

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true     -- Tab inserts blanks according to following settings.
vim.o.expandtab = true    -- Use spaces to indent.
vim.o.tabstop = 4         -- \t is displayed as 4 spaces.
vim.o.shiftwidth = 0      -- Inherit from tabstop.
vim.o.softtabstop = 0     -- Inherit from tabstop.

-- General look
vim.o.termguicolors = true
-- Line appearance
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.cursorline = true
vim.wo.wrap = false
-- Floating windows
vim.o.winborder='single'

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Movement
vim.o.whichwrap = "<,>,[,]"

-- Autocompletion
vim.opt.completeopt = {"menuone", "noselect", "popup"}

-- Custom formatting of the quickfix list.
local qf_error_map = {
  -- Empty / missing default to errors.
  [""] = "E",
  [" "] = "E",

  -- Canonical one-letter forms.
  e = "E",
  w = "W",
  i = "I",
  n = "N",

  -- Common words from tools.
  error = "E",
  err = "E",
  fatal = "E",
  warning = "W",
  warn = "W",
  info = "I",
  information = "I",
  note = "N",
  hint = "I",
}

function quickfixtextfunc(info)
  -- Get the information from the quicklist.
  if info.quickfix == 1 then
    items = vim.fn.getqflist({id = info.id, items = 0}).items
  else
    items = vim.fn.getloclist(info.winid, {id = info.id, items = 0}).items
  end

  -- Format each line.
  lines = {}
  for i = info.start_idx, info.end_idx do
    local entry = items[i]
    local line = "<error>"
    if entry.valid == 1 then
      local name = ""
      if entry.bufnr > 0 then
        name = vim.fn.bufname(entry.bufnr)
      else
        name = "[" .. tostring(entry.bufnr) .. "]"
      end

      local fmt = "%s %s:%d:%d: %s"
      local displayed_type = qf_error_map[vim.trim(entry.type):lower()]
      if not displayed_type then
        displayed_type = "U"
      end
      line = fmt:format(displayed_type, name, entry.lnum, entry.col, entry.text)
    else
      line = "│ " .. entry.text
    end
    table.insert(lines, line)
  end
  return lines
end
vim.o.quickfixtextfunc = "{info -> v:lua.quickfixtextfunc(info)}"
