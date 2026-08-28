local function header()
  return table.concat({
    '',
    '  ╭──────────────────────────╮',
    '  │     n v i m              │',
    '  ╰──────────────────────────╯',
    '',
  }, '\n')
end

local function footer()
  return table.concat({
    '',
    '  type `:q<CR>` to exit  ·  press `?` for help',
  }, '\n')
end

return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    local starter = require 'mini.starter'
    starter.setup {
      autoopen = true,
      evaluate_single = false,
      header = header,
      footer = footer,
      items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(15, false),
        starter.sections.recent_files(10, true),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing('all', { 'Builtin actions' }),
        starter.gen_hook.padding(3, 2),
      },
    }
  end,
}
