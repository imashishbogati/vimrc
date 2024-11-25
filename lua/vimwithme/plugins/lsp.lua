local lsp_zero = require('lsp-zero')
-- Default LSP settings
lsp_zero.preset('recommended')
-- Setup Mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "cssls",                 -- CSS language server
    "css_variables",         -- CSS variables language server
    "cssmodules_ls",         -- CSS modules language server
    "gopls",                 -- Go language server
    "html",                  -- HTML language server
    "lua_ls",                -- Lua language server
    "nginx_language_server", -- Nginx language server
    "pylsp",                 -- Python language server
    "rust_analyzer",         -- Rust language server
    "tailwindcss",           -- Tailwind CSS language server
    "ts_ls",                 -- TypeScript/JavaScript language server (corrected name)
  },
  handlers = {
    lsp_zero.default_setup,
  }
})
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- LSP keymaps
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- Format on save (optional)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end
-- TypeScript specific setup
require('lspconfig').ts_ls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr) -- Apply default keymaps
  end,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    typescript = {
      inlayHints = false
    },
    javascript = {
      inlayHints = false
    }
  }
})

require('lspconfig').gopls.setup({
  on_attach = on_attach
})

require('lspconfig').rust_analyzer.setup({
  on_attach = on_attach
})

require('lspconfig').cssls.setup({
  on_attach = on_attach
})

require('lspconfig').css_variables.setup({
  on_attach = on_attach
})

require('lspconfig').cssmodules_ls.setup({
  on_attach = on_attach
})

require('lspconfig').html.setup({
  on_attach = on_attach
})

require('lspconfig').lua_ls.setup({
  on_attach = on_attach
})

require('lspconfig').nginx_language_server.setup({
  on_attach = on_attach
})

require('lspconfig').pylsp.setup({
  on_attach = on_attach
})

require('lspconfig').tailwindcss.setup({
  on_attach = on_attach
})

lsp_zero.setup()
