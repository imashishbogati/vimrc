local telescope = require('telescope')

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git/"
        }
    }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pz', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
