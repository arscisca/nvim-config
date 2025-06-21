vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'html' },
  callback = function()
    vim.o.tabstop = 2
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local ts = require('nvim-treesitter')

    -- Is this buffer too big?
    local fname = vim.api.nvim_buf_get_name(0)
    local fsize = vim.fn.getfsize(fname)
    local maxsize = 1024 * 1024  -- 1 MiB
    if fsize > maxsize then
        return
    end

    -- Is the parser installed?
    local installed = ts.get_installed('parsers')
    if not vim.list_contains(installed, vim.bo.filetype) then
      return
    end

    -- Start treesitter and use its power.
    vim.treesitter.start()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
