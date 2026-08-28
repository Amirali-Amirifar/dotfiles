---@type Plugin
return {
  spec = {
    'https://github.com/sindrets/diffview.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
  },
  setup = function()
    require('diffview').setup {}
    vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewOpen<CR>', { desc = '[G]it [D]iffview' })
    vim.keymap.set('n', '<leader>gC', '<cmd>DiffviewClose<CR>', { desc = '[G]it diffview [C]lose' })
    vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = '[G]it file [H]istory' })
    vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<CR>', { desc = '[G]it branch [H]istory' })
  end,
}
