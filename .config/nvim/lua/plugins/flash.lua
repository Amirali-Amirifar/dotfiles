---@type Plugin
return {
  spec = { 'https://github.com/folke/flash.nvim' },
  setup = function()
    require('flash').setup {}

    local flash = require 'flash'
    vim.keymap.set({ 'n', 'x', 'o' }, 's', function() flash.jump() end, { desc = 'Flash jump' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() flash.treesitter() end, { desc = 'Flash treesitter' })
    vim.keymap.set('o', 'r', function() flash.remote() end, { desc = 'Remote flash' })
    vim.keymap.set({ 'o', 'x' }, 'R', function() flash.treesitter_search() end, { desc = 'Treesitter search' })
    vim.keymap.set('c', '<c-s>', function() flash.toggle() end, { desc = 'Toggle flash search' })
  end,
}
