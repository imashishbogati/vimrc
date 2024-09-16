vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- Git add current file
vim.keymap.set('n', '<leader>ga', ':!git add %<CR>')

-- Git add all changes
vim.keymap.set('n', '<leader>gA', ':!git add .<CR>')

-- Git commit with message prompt
vim.keymap.set('n', '<leader>gc', ':!git commit -m ""<Left>')

-- Git push
vim.keymap.set('n', '<leader>gp', ':!git push<CR>')

-- Git pull
vim.keymap.set('n', '<leader>gl', ':!git pull<CR>')
