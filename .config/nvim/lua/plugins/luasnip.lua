return {
  spec = { { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' } },
  setup = function() require('luasnip').setup {} end,
}
