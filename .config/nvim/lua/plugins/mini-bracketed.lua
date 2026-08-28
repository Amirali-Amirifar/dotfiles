---@type Plugin
return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    require('mini.bracketed').setup {
      comment = { suffix = '' },
    }
  end,
}
