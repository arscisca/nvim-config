-- Formatting
vim.g.autoformat = false

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true     -- Tab inserts blanks according to following settings.
vim.o.expandtab = true    -- Use spaces to indent.
vim.o.tabstop = 4         -- \t is displayed as 4 spaces.
vim.o.shiftwidth = 0      -- Inherit from tabstop.
vim.o.softtabstop = 0     -- Inherit from tabstop.

-- General look
-- Line appearance
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.cursorline = true
-- Command line
vim.g.cmdheight = 0

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Custom keymaps
require('config.keymaps')
