vim.g.netrw_banner = 0 -- Disable banner

vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor",
    "i-ci-ve:hor1-CursorInsert/lCursorInsert",
    "r-cr:hor1-CursorReplace/lCursorReplace",
    "o:hor1-CursorOperator/lCursorOperator"
}

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"


