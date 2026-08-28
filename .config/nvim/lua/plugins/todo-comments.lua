return {
  spec = { 'https://github.com/folke/todo-comments.nvim' },
  setup = function() require('todo-comments').setup { signs = false } end,
}
