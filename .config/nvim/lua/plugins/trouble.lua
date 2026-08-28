---@type Plugin
return {
  spec = { 'https://github.com/folke/trouble.nvim' },
  setup = function()
    require('trouble').setup {}

    vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (workspace)' })
    vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Diagnostics (buffer)' })
    vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<CR>', { desc = '[S]ymbols outline' })
    vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', { desc = '[L]SP refs/defs' })
    vim.keymap.set('n', '<leader>xt', '<cmd>Trouble todo<CR>', { desc = '[T]odo comments' })
  end,
}
