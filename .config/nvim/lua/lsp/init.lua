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
require('pack').add(mason.spec)
mason.setup(servers)

for _, name in ipairs(servers) do
  vim.lsp.config(name, require('lsp.servers.' .. name))
  vim.lsp.enable(name)
end

require 'lsp.attach'
