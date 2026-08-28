return {
  spec = { 'https://github.com/Wansmer/symbol-usage.nvim' },
  setup = function()
    require('symbol-usage').setup {
      vt_position = 'end_of_line',
      text_format = function(symbol)
        local refs = symbol.references
        if refs and refs > 0 then return (' %d ref%s'):format(refs, refs == 1 and '' or 's') end
        return ''
      end,
    }
  end,
}
