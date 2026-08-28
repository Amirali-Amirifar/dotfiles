---@type Plugin
return {
  spec = { 'https://github.com/MagicDuck/grug-far.nvim' },
  setup = function()
    require('grug-far').setup {}
    vim.keymap.set('n', '<leader>S', function() require('grug-far').open() end, { desc = '[S]earch & replace project-wide' })
    vim.keymap.set('v', '<leader>S', function() require('grug-far').with_visual_selection() end, { desc = '[S]earch & replace selection' })
  end,
}
