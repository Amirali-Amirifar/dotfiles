local format_on_save_fts = {
  go = true,
  lua = true,
  python = true,
  rust = true,
  sh = true,
  bash = true,
  c = true,
  cpp = true,
}

return {
  spec = { 'https://github.com/stevearc/conform.nvim' },
  setup = function()
    local prettier = { 'prettierd', 'prettier', stop_after_first = true }

    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if format_on_save_fts[vim.bo[bufnr].filetype] then return { timeout_ms = 1000, lsp_format = 'fallback' } end
      end,
      default_format_opts = {
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        go = { 'gofumpt' },
        lua = { 'stylua' },
        python = { 'ruff_organize_imports', 'ruff_format' },
        rust = { 'rustfmt' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        sql = { 'sqlfluff' },
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        yaml = prettier,
        markdown = prettier,
        html = prettier,
        css = prettier,
        scss = prettier,
      },
      formatters = {
        sqlfluff = { args = { 'format', '--dialect=postgres', '-' }, stdin = true },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
  end,
}
