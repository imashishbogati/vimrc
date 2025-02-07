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
    "intelephense",
    "zls",
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

--[[ require('lspconfig').intelephense.setup({
  on_attach = on_attach,
  root_dir = function(fname)
    local root = require('lspconfig.util').root_pattern('index.php')(fname)
    return root or require('lspconfig.util').path.dirname(fname)
  end,
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000
      }
    }
  }
}) ]]

local function php_on_attach(client, bufnr)
  if vim.bo[bufnr].filetype ~= "php" then
    return
  end

  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

require('lspconfig').intelephense.setup({
  on_attach = php_on_attach,
  root_dir = function(fname)
    return require('lspconfig.util').root_pattern(
      'composer.json',
      'artisan',
      '.git',
      'index.php'
    )(fname) or require('lspconfig.util').path.dirname(fname)
  end,
  filetypes = { "php" },
  settings = {
    intelephense = {
      files = {
        maxSize = 5000000,
        associations = { "*.php" },
      },
      environment = {
        includePaths = { 'vendor' },
      },
      stubs = {
        "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl",
        "date", "dba", "dom", "enchant", "exif", "fileinfo", "filter", "fpm", "ftp",
        "gd", "hash", "iconv", "imap", "interbase", "intl", "json", "ldap", "libxml",
        "mbstring", "mcrypt", "meta", "mssql", "mysqli", "oci8", "odbc", "openssl",
        "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite",
        "pgsql", "Phar", "posix", "pspell", "readline", "recode", "Reflection",
        "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL",
        "sqlite3", "standard", "superglobals", "sybase", "sysvmsg", "sysvsem",
        "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter",
        "xsl", "Zend OPcache", "zip", "zlib"
      },
      completion = {
        insertUseDeclaration = true,
        fullyQualifyGlobalConstantsAndFunctions = true,
      },
      diagnostics = {
        enable = true,
      },
      format = {
        enable = true,
      },
    },
  },
})

lsp_zero.setup()
