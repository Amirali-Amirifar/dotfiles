return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    require('mini.ai').setup {
      mappings = {
        around_next = 'aa',
        inside_next = 'ii',
      },
      n_lines = 500,
    }
    require('mini.surround').setup()
    require('plugins.mini-starter').setup()
    require('plugins.mini-statusline').setup()
    require('mini.move').setup()
    require('mini.bracketed').setup { comment = { suffix = '' } }
    require('mini.bufremove').setup()
    vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0, false) end, { desc = '[B]uffer [D]elete' })
    vim.keymap.set('n', '<leader>bD', function() require('mini.bufremove').delete(0, true) end, { desc = '[B]uffer [D]elete (force)' })
  end,
}
