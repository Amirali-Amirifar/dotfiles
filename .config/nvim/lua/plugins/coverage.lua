---@type Plugin
return {
  spec = {
    'https://github.com/andythigpen/nvim-coverage',
    'https://github.com/nvim-lua/plenary.nvim',
  },
  setup = function()
    local coverage = require 'coverage'

    coverage.setup {
      auto_reload = true,
      lang = {
        go = { coverage_file = 'coverage.out' },
      },
    }

    vim.keymap.set('n', '<leader>nc', function() coverage.load(true) end, { desc = '[N]eotest: load [C]overage' })
    vim.keymap.set('n', '<leader>nC', function() coverage.toggle() end, { desc = '[N]eotest: toggle [C]overage' })
  end,
}
