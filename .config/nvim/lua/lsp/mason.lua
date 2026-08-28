local tools = {
  'gofumpt',
  'stylua',
  'ruff',
  'prettierd',
  'shfmt',
  'clang-format',
  'sqlfluff',
  'markdownlint',
  'shellcheck',
  'hadolint',
  'golangci-lint',
  'bandit',
}

local function setup(servers)
  require('mason').setup {}
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_enable = false,
  }

  local ensure_installed = {}
  vim.list_extend(ensure_installed, servers)
  vim.list_extend(ensure_installed, tools)

  require('mason-tool-installer').setup {
    ensure_installed = ensure_installed,
  }
end

return {
  spec = {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  setup = setup,
}
