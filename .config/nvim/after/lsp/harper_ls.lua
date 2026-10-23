---@type vim.lsp.Config
return {
  filetypes = { 'markdown', 'gitcommit' },
  settings = {
    ['harper-ls'] = {
      linters = {
        SpellCheck = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongQuotes = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = true,
      },
    },
  },
}
