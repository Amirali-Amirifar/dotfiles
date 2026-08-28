---@type Plugin
return {
  spec = { 'https://github.com/stevearc/quicker.nvim' },
  setup = function()
    require('quicker').setup {
      keys = {
        { '>', function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end, desc = 'Expand quickfix context' },
        { '<', function() require('quicker').collapse() end, desc = 'Collapse quickfix context' },
      },
    }
    vim.keymap.set('n', '<leader>xq', function() require('quicker').toggle() end, { desc = 'Toggle [Q]uickfix' })
    vim.keymap.set('n', '<leader>xL', function() require('quicker').toggle { loclist = true } end, { desc = 'Toggle [L]oclist' })
  end,
}
