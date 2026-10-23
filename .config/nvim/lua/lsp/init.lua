local servers = {
  'gopls',
  'golangci_lint_ls',
  'lua_ls',
  'basedpyright',
  'ts_ls',
  'clangd',
  'rust_analyzer',
  'bashls',
  'dockerls',
  'marksman',
  'mdx_analyzer',
  'texlab',
  'jsonls',
  'yamlls',
  'sqlls',
  'harper_ls',
}

local mason = require 'lsp.mason'
vim.pack.add(mason.spec)
mason.setup(servers)

vim.lsp.enable(servers)

require 'lsp.attach'
