local function mode_label()
  local statusline = require 'mini.statusline'
  local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
  return ' ' .. mode:upper() .. ' ', mode_hl
end

local function git_summary()
  local s = require('mini.statusline').section_git { trunc_width = 75 }
  local d = require('mini.statusline').section_diff { trunc_width = 75 }
  if s == '' and d == '' then return '' end
  return (s ~= '' and s or '') .. (d ~= '' and ' ' .. d or '')
end

local function diagnostics()
  return require('mini.statusline').section_diagnostics {
    trunc_width = 75,
    signs = { ERROR = ' ', WARN = ' ', INFO = ' ', HINT = ' ' },
  }
end

local function lsp_clients() return require('mini.statusline').section_lsp { trunc_width = 75, icon = '󰒋' } end

local function cwd()
  local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  if name == '' then return '' end
  return '  ' .. name
end

local function filename()
  local f = vim.fn.expand '%:.'
  if f == '' then return '%f%m%r' end
  return f .. '%m%r'
end

local function filetype()
  local ft = vim.bo.filetype
  if ft == '' then return '' end
  return ft
end

local function position() return '%2l:%-2v' end
local function percent() return ' %2p%%' end

return {
  spec = { 'https://github.com/nvim-mini/mini.nvim' },
  setup = function()
    local statusline = require 'mini.statusline'
    statusline.setup {
      use_icons = vim.g.have_nerd_font,
      content = {
        active = function()
          local mode, mode_hl = mode_label()
          local git = git_summary()
          local diag = diagnostics()
          local dir = cwd()
          local file = filename()
          local ft = filetype()
          local lsp = lsp_clients()
          local pos = position()
          local pct = percent()

          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diag } },
            '%<',
            { hl = 'MiniStatuslineDirectory', strings = { dir } },
            { hl = 'MiniStatuslineFilename', strings = { file } },
            '%=',
            { hl = 'MiniStatuslineFileinfo', strings = { ft, lsp } },
            { hl = mode_hl, strings = { pos } },
            { hl = 'MiniStatuslineDevinfo', strings = { pct } },
          }
        end,
        inactive = nil,
      },
    }
  end,
}
