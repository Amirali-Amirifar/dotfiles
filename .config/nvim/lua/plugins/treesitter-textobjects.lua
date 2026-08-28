return {
  spec = { { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } },
  setup = function()
    require('nvim-treesitter-textobjects').setup {
      select = { lookahead = true },
      move = { set_jumps = true },
    }

    local select = require 'nvim-treesitter-textobjects.select'
    local function sel(query)
      return function() select.select_textobject(query, 'textobjects') end
    end
    for lhs, q in pairs {
      ['aF'] = '@function.outer',
      ['iF'] = '@function.inner',
      ['aC'] = '@class.outer',
      ['iC'] = '@class.inner',
      ['aA'] = '@parameter.outer',
      ['iA'] = '@parameter.inner',
      ['ab'] = '@code_cell.outer',
      ['ib'] = '@code_cell.inner',
    } do
      vim.keymap.set({ 'x', 'o' }, lhs, sel(q), { desc = 'Select ' .. q })
    end

    local move = require 'nvim-treesitter-textobjects.move'
    for _, m in ipairs {
      { ']f', move.goto_next_start, '@function.outer', 'Next function start' },
      { '[f', move.goto_previous_start, '@function.outer', 'Prev function start' },
      { ']F', move.goto_next_end, '@function.outer', 'Next function end' },
      { '[F', move.goto_previous_end, '@function.outer', 'Prev function end' },
      { ']C', move.goto_next_start, '@class.outer', 'Next class start' },
      { '[C', move.goto_previous_start, '@class.outer', 'Prev class start' },
      { ']b', move.goto_next_start, '@code_cell.inner', 'Next code cell' },
      { '[b', move.goto_previous_start, '@code_cell.inner', 'Prev code cell' },
    } do
      vim.keymap.set({ 'n', 'x', 'o' }, m[1], function() m[2](m[3], 'textobjects') end, { desc = m[4] })
    end
  end,
}
