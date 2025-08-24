-- Change tabsize based on filetype.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'html' },
  callback = function()
    vim.o.tabstop = 2
  end
})

-- Enable or disable treesitter.
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

-- Autocompletion on LSP attach.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp.config', {clear = false}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end
  end
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('lsp.config', {clear = true}),
  callback = function(args)
  end,
})
