-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Indentation depends on file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  command = "setlocal shiftwidth=2 tabstop=2",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  command = "setlocal shiftwidth=2 tabstop=2",
})
