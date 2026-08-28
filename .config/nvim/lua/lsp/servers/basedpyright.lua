---@type vim.lsp.Config
return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'standard',
        autoImportCompletions = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = false,
        },
      },
    },
  },
}
