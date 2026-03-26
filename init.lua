require('config.lazy')
require('config.colorscheme')
require('config.autocommands')
require('config.keymaps')
require('config.commands')

-- Add the possibility of having local overrides outside of this repo.
vim.opt.runtimepath:append("vim.fn.getcwd()" .. "/.nvim")               -- Per project.
vim.opt.runtimepath:append(os.getenv("HOME") .. "/.config/nvim/local")  -- Per machine.
