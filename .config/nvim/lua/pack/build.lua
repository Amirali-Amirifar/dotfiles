local function build(name, command, cwd)
  local result = vim.system(command, { cwd = cwd }):wait()
  if result.code == 0 then return end

  local output = result.stderr and result.stderr ~= '' and result.stderr or result.stdout
  if not output or output == '' then output = 'Build command produced no output.' end
  vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local data = event.data
    if data.kind ~= 'install' and data.kind ~= 'update' then return end

    local name = data.spec.name
    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      build(name, { 'make' }, data.path)
    elseif name == 'LuaSnip' and vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
      build(name, { 'make', 'install_jsregexp' }, data.path)
    elseif name == 'nvim-treesitter' then
      if not data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})
