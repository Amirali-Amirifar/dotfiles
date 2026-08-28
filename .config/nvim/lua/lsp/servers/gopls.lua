---@type vim.lsp.Config
return {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      semanticTokens = true,
      usePlaceholders = true,
      completeUnimported = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-node_modules' },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        shadow = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
}
