-- Run from the repository root: nvim --clean --headless -l tests/go-save.lua
local first = vim.api.nvim_create_buf(true, false)
local second = vim.api.nvim_create_buf(true, false)
for _, buffer in ipairs { first, second, second } do
  vim.api.nvim_set_current_buf(buffer)
  dofile '.config/nvim/after/ftplugin/go.lua'
end
local hooks = vim.api.nvim_get_autocmds { group = 'go-organize-imports' }
assert(#hooks == 2, 'Each Go buffer must retain exactly one save hook')
for _, buffer in ipairs { first, second } do
  assert(#vim.api.nvim_get_autocmds { group = 'go-organize-imports', buffer = buffer } == 1)
end
print 'Go save hooks survive opening another buffer and reloading the ftplugin'
