---@type vim.lsp.Config
return {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = 'clippy' },
      inlayHints = {
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
}
