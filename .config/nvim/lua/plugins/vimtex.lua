---@type Plugin
return {
  spec = { 'https://github.com/lervag/vimtex' },
  setup = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1

    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = 'build',
      out_dir = 'build',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }

    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_quickfix_mode = 0

    if vim.g.maplocalleader == nil or vim.g.maplocalleader == '' then vim.g.maplocalleader = '\\' end

    local texbin = '/Library/TeX/texbin'
    if vim.fn.isdirectory(texbin) == 1 and not string.find(vim.env.PATH or '', texbin, 1, true) then vim.env.PATH = texbin .. ':' .. (vim.env.PATH or '') end
  end,
}
