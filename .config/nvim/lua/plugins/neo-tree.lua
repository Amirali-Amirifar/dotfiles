local spec = {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}
if vim.g.have_nerd_font then table.insert(spec, 'https://github.com/nvim-tree/nvim-web-devicons') end

return {
  spec = spec,
  setup = function()
    vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal current file', silent = true })
    vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'NeoTree [E]xplorer toggle', silent = true })
    vim.keymap.set('n', '<leader>be', '<Cmd>Neotree source=buffers toggle<CR>', { desc = 'NeoTree [B]uffers', silent = true })
    vim.keymap.set('n', '<leader>ge', '<Cmd>Neotree source=git_status toggle<CR>', { desc = 'NeoTree [G]it status', silent = true })
    vim.keymap.set('n', '<leader>oe', '<Cmd>Neotree source=document_symbols toggle<CR>', { desc = 'NeoTree [O]utline / symbols', silent = true })

    require('neo-tree').setup {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      source_selector = {
        winbar = true,
        content_layout = 'center',
        tabs_layout = 'equal',
        sources = {
          { source = 'filesystem', display_name = '  Files ' },
          { source = 'buffers', display_name = '  Bufs ' },
          { source = 'git_status', display_name = '  Git ' },
          { source = 'document_symbols', display_name = '  Syms ' },
        },
      },
      close_if_last_window = false,
      enable_git_status = true,
      enable_diagnostics = true,
      enable_modified_markers = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
          expander_collapsed = '\u{f054}',
          expander_expanded = '\u{f078}',
          indent_marker = '\u{2502}',
          last_indent_marker = '\u{2514}',
        },
        icon = {
          folder_closed = '\u{f07b}',
          folder_open = '\u{f07c}',
          folder_empty = '\u{f114}',
          default = '\u{f15b}',
        },
        modified = { symbol = '\u{25cf}' },
        git_status = {
          symbols = {
            added = '\u{271a}',
            modified = '\u{f040}',
            deleted = '\u{2716}',
            renamed = '\u{2192}',
            untracked = '?',
            ignored = '\u{25cc}',
            unstaged = '\u{25cb}',
            staged = '\u{2713}',
            conflict = '\u{26a0}',
          },
        },
        file_size = { enabled = true, required_width = 64 },
        type = { enabled = true, required_width = 110 },
        last_modified = { enabled = false },
        created = { enabled = false },
        symlink_target = { enabled = true },
      },
      window = {
        position = 'left',
        width = 34,
        mapping_options = { noremap = true, nowait = true },
        mappings = {
          ['\\'] = 'close_window',
          ['<space>'] = 'none',
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<CR>'] = 'open',
          ['o'] = 'system_open',
          ['<C-v>'] = 'open_vsplit',
          ['<C-x>'] = 'open_split',
          ['<C-t>'] = 'open_tabnew',
          ['Y'] = 'copy_relative_path',
          ['gy'] = 'copy_absolute_path',
          ['/'] = 'fuzzy_finder',
          ['F'] = 'filter_on_submit',
          ['<C-c>'] = 'clear_filter',
          ['?'] = 'show_help',
        },
      },
      filesystem = {
        bind_to_cwd = true,
        cwd_target = { sidebar = 'tab', current = 'window' },
        follow_current_file = { enabled = true, leave_dirs_open = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'open_current',
        group_empty_dirs = false,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {},
          hide_by_pattern = {},
          never_show = {},
        },
        find_by_full_path_words = true,
        window = {
          fuzzy_finder_mappings = {
            ['<Down>'] = 'move_cursor_down',
            ['<Up>'] = 'move_cursor_up',
            ['<C-n>'] = 'move_cursor_down',
            ['<C-p>'] = 'move_cursor_up',
            ['<Esc>'] = 'close',
          },
        },
        commands = {
          system_open = function(state) vim.ui.open(state.tree:get_node():get_id()) end,
          copy_relative_path = function(state)
            local rel = vim.fn.fnamemodify(state.tree:get_node():get_id(), ':.')
            vim.fn.setreg('+', rel)
            vim.notify('Yanked: ' .. rel)
          end,
          copy_absolute_path = function(state)
            local p = state.tree:get_node():get_id()
            vim.fn.setreg('+', p)
            vim.notify('Yanked: ' .. p)
          end,
        },
      },
      buffers = {
        follow_current_file = { enabled = true, leave_dirs_open = false },
        group_empty_dirs = true,
        show_unloaded = true,
      },
      git_status = {},
      document_symbols = {
        follow_cursor = true,
        client_filters = 'first',
      },
    }
  end,
}
