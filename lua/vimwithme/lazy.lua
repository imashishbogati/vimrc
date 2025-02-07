-- plugins.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin configuration
require('lazy').setup({
  -- Your existing plugins
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require('vimwithme.plugins.todocomment')
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('vimwithme.plugins.treesitter')
    end
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-neotest/nvim-nio' },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('vimwithme.plugins.harpoon')
    end
  },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      require('vimwithme.plugins.lsp')
    end
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    'tpope/vim-surround',
  },
  {
    'tpope/vim-repeat',
  },
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Jupyter Notebook Integration with Molten
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },

  -- Markdown preview for documentation
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    build = function()
      vim.fn.system('cd app && npx --yes yarn install')
    end,
    cmd = { 'MarkdownPreview' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
    end,
  },

  -- Debugging support
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()
      require('dap-python').setup('python')

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  -- Testing framework
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-python')({
            dap = { justMyCode = false },
            pytest_discovery = true,
          }),
        },
      })
    end
  },
}, {
  install = {
    colorscheme = { "rose-pine" }
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- Load additional configurations
require('vimwithme.set')
require('vimwithme.remap')
require('vimwithme.plugins.colors')
require('vimwithme.plugins.undotree')
require('vimwithme.plugins.telescope')

-- Autocommands
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Python Development specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Indentation settings
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4

    -- Python keymaps
    local opts = { buffer = true, silent = true }

    -- Molten keymaps
    vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', opts)
    vim.keymap.set('n', '<leader>me', ':MoltenEvaluateOperator<CR>', opts)
    vim.keymap.set('n', '<leader>ml', ':MoltenEvaluateLine<CR>', opts)
    vim.keymap.set('v', '<leader>me', ':<C-u>MoltenEvaluateVisual<CR>gv', opts)
    vim.keymap.set('n', '<leader>mr', ':MoltenRestart<CR>', opts)
    vim.keymap.set('n', '<leader>mo', ':MoltenShowOutput<CR>', opts)
    vim.keymap.set('n', '<leader>mh', ':MoltenHideOutput<CR>', opts)
    vim.keymap.set('n', '<leader>md', ':MoltenDelete<CR>', opts)
    vim.keymap.set('n', '<leader>mn', ':MoltenImportOutput<CR>', opts)

    -- Testing
    vim.keymap.set('n', '<leader>pt', ':lua require("neotest").run.run()<CR>', opts)

    -- Debugging
    vim.keymap.set('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', opts)
    vim.keymap.set('n', '<leader>dc', ':lua require("dap").continue()<CR>', opts)
    vim.keymap.set('n', '<leader>do', ':lua require("dap").step_over()<CR>', opts)
    vim.keymap.set('n', '<leader>di', ':lua require("dap").step_into()<CR>', opts)
    vim.keymap.set('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', opts)
  end,
})

-- Additional keymaps for markdown preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }
    vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', opts)
    vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', opts)
  end,
})
