local lsp_zero = require('lsp-zero')

-- Default LSP settings
lsp_zero.preset('recommended')

-- Setup language servers with Mason
require('mason').setup({})

require('mason-lspconfig').setup({
  ensure_installed = {
    "gopls",         -- Go language server
    "rust_analyzer", -- Rust language server
    "html",          -- HTML language server
    "ts_ls",         -- TypeScript/JavaScript language server
  },
  handlers = {
    lsp_zero.default_setup, -- Ensures default setup for installed servers
  }
})


-- Custom on_attach function to define LSP keybindings
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Keymaps for LSP actions
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)        -- Go to Definition
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)              -- Hover documentation
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)    -- Go to Implementation
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) -- Signature Help
end

require('lspconfig').ts_ls.setup({
  on_attach = function(client, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
  end
})

-- Setup LSP and attach keymaps
lsp_zero.setup({
  on_attach = on_attach
})
