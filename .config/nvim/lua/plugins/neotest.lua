---@type Plugin
return {
  spec = {
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/fredrikaverpil/neotest-golang',
    'https://github.com/nvim-neotest/neotest-python',
  },
  setup = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-golang' {},
        require 'neotest-python' { runner = 'pytest' },
      },
    }

    local n = function() return require 'neotest' end
    vim.keymap.set('n', '<leader>nn', function() n().run.run() end, { desc = '[N]eotest: run [N]earest' })
    vim.keymap.set('n', '<leader>nf', function() n().run.run(vim.fn.expand '%') end, { desc = '[N]eotest: run [F]ile' })
    vim.keymap.set('n', '<leader>nl', function() n().run.run_last() end, { desc = '[N]eotest: run [L]ast' })
    vim.keymap.set('n', '<leader>ns', function() n().summary.toggle() end, { desc = '[N]eotest: [S]ummary' })
    vim.keymap.set('n', '<leader>no', function() n().output.open { enter = true, auto_close = true } end, { desc = '[N]eotest: [O]utput' })
    vim.keymap.set('n', '<leader>nO', function() n().output_panel.toggle() end, { desc = '[N]eotest: [O]utput panel' })
    vim.keymap.set('n', '<leader>nx', function() n().run.stop() end, { desc = '[N]eotest: stop' })
  end,
}
