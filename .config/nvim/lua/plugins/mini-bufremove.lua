---@type Plugin
return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    require('mini.bufremove').setup()
    vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0, false) end, { desc = '[B]uffer [D]elete' })
    vim.keymap.set('n', '<leader>bD', function() require('mini.bufremove').delete(0, true) end, { desc = '[B]uffer [D]elete (force)' })
  end,
}
