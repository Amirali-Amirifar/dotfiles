return {
  spec = { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } },
  setup = function()
    require('nvim-treesitter').install {
      'bash',
      'diff',
      'lua',
      'luadoc',
      'query',
      'vim',
      'vimdoc',
      'markdown',
      'markdown_inline',
      'regex',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'python',
      'javascript',
      'typescript',
      'tsx',
      'c',
      'cpp',
      'rust',
      'dockerfile',
      'json',
      'yaml',
      'toml',
      'html',
      'css',
      'scss',
      'sql',
      'gitcommit',
      'git_rebase',
      'gitignore',
      'gitattributes',
    }

    vim.treesitter.language.register('json', { 'jsonc', 'json5' })
    vim.treesitter.language.register('markdown', 'mdx')

    local available_parsers = require('nvim-treesitter').get_available()

    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then return end
      vim.treesitter.start(buf, language)
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'
      local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil
      if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end
        local installed = require('nvim-treesitter').get_installed 'parsers'
        if vim.tbl_contains(installed, language) then
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
        else
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
}
