---@type Plugin
return {
  spec = { 'https://github.com/folke/which-key.nvim' },
  setup = function()
    require('which-key').setup {
      delay = 100,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it' },
        { '<leader>x', group = 'Trouble / [X]quickfix' },
        { '<leader>n', group = '[N]eotest' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>o', group = '[O]utline' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    }
  end,
}
