return {
  spec = { 'https://github.com/rebelot/kanagawa.nvim' },
  setup = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup {
      compile = true,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      theme = 'wave',
      background = { dark = 'wave', light = 'lotus' },
      overrides = function(_)
        local none = 'NONE'
        local t = {}
        for _, g in ipairs {
          'Normal',
          'NormalNC',
          'NormalFloat',
          'FloatBorder',
          'FloatTitle',
          'SignColumn',
          'EndOfBuffer',
          'VertSplit',
          'WinSeparator',
          'StatusLine',
          'StatusLineNC',
          'TabLine',
          'TabLineFill',
          'NeoTreeNormal',
          'NeoTreeNormalNC',
          'NeoTreeEndOfBuffer',
          'NeoTreeWinSeparator',
          'TelescopeNormal',
          'TelescopeBorder',
          'TelescopePromptNormal',
          'TelescopePromptBorder',
          'TelescopeResultsNormal',
          'TelescopeResultsBorder',
          'TelescopePreviewNormal',
          'TelescopePreviewBorder',
          'WhichKeyFloat',
          'TroubleNormal',
        } do
          t[g] = { bg = none }
        end
        t.NeoTreeWinSeparator = { bg = none, fg = none }
        t.NeoTreeRootName = { bold = true }
        return t
      end,
    }
    vim.cmd.colorscheme 'kanagawa-wave'
  end,
}
