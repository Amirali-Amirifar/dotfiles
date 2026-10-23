---@type vim.lsp.Config
return {
  settings = {
    sqlLanguageServer = {
      lint = {
        rules = {
          ['align-column-to-the-first'] = 'error',
          ['column-new-line'] = 'error',
          ['linebreak-after-clause-keyword'] = 'off',
          ['reserved-word-case'] = { 'error', 'upper' },
          ['space-surrounding-operators'] = 'error',
          ['where-clause-new-line'] = 'error',
          ['align-where-clause-to-the-first'] = 'error',
        },
      },
    },
  },
}
