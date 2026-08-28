vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank to end of line' })
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Write buffer' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus right window' })
