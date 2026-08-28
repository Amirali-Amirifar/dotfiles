if vim.fn.has 'nvim-0.12' ~= 1 then error 'This configuration requires Neovim 0.12 or newer.' end

vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'core.diagnostics'

require 'pack.build'
require('pack').load_all(require 'plugins.manifest')
require 'lsp'
