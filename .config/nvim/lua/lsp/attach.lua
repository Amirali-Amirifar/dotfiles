local attach_group = vim.api.nvim_create_augroup('lsp-attach', { clear = true })
local highlight_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })
local detach_group = vim.api.nvim_create_augroup('lsp-detach', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = attach_group,
  callback = function(event)
    local function map(keys, action, description, mode)
      vim.keymap.set(mode or 'n', keys, action, {
        buffer = event.buf,
        desc = 'LSP: ' .. description,
      })
    end

    map('grn', vim.lsp.buf.rename, 'Rename')
    map('gra', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
    map('grD', vim.lsp.buf.declaration, 'Declaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    if client:supports_method('textDocument/documentHighlight', event.buf) then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        buffer = event.buf,
        group = detach_group,
        once = true,
        callback = function(args)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = highlight_group, buffer = args.buf }
        end,
      })
    end

    if client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
      end, 'Toggle inlay hints')
    end
  end,
})
