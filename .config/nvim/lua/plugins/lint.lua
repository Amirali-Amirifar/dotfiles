return {
  spec = { 'https://github.com/mfussenegger/nvim-lint' },
  setup = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      dockerfile = { 'hadolint' },
      python = { 'ruff', 'bandit' },
      sql = { 'sqlfluff' },
    }
    lint.linters.sqlfluff.args = { 'lint', '--format=json', '--dialect=postgres' }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
