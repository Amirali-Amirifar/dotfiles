return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    require('mini.ai').setup {
      mappings = {
        around_next = 'aa',
        inside_next = 'ii',
      },
      n_lines = 500,
    }
  end,
}
