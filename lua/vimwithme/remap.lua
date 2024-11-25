vim.g.mapleader = " " -- Set leader key to space

-- Map <leader>lg to open Lazygit
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })

-- Open NetRW file explorer (Go Back in the directory structure)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected line down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Move selected line up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Scroll down half a page and center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scroll up half a page and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to next search result and center the cursor
vim.keymap.set("n", "n", "nzzzv")

-- Move to previous search result and center the cursor
vim.keymap.set("n", "N", "Nzzzv")

-- Paste in visual mode without overwriting the current register
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank to system clipboard in normal and visual mode
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Remap Ctrl-C to ESC in insert mode
vim.keymap.set("i", "<C-c>", "<ESC>")

-- Open new tmux window using tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Open a new tmux window
vim.keymap.set("n", "<leader>nw", function()
  vim.fn.system("tmux neww")
end, { desc = "New Tmux Window" })

-- Format code using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Navigate to next item in quickfix list and center the cursor
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Navigate to previous item in quickfix list and center the cursor
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Navigate to next item in location list and center the cursor
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Navigate to previous item in location list and center the cursor
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Quickly insert error handling in Go (if err != nil { return err })
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Show diagnostics (errors/warnings) at the cursor
vim.keymap.set('n', 'ge', vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = "Show diagnostics (errors/warnings)" })

-- Fun command: Make it rain using CellularAutomaton
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Go To next error in buffer
vim.keymap.set("n", "<leader>ne", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>zz",
  { noremap = true, silent = true, desc = "Go to next error" })

-- Go To prev error in buffer
vim.keymap.set("n", "<leader>pe", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>zz",
  { noremap = true, silent = true, desc = "Go to previous error" })

-- Source the current Vim configuration file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)
