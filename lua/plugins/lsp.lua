local features = require('feature-loader')

return {
  -- LSP server installer / manager
  {
    'williamboman/mason.nvim',
    enabled = features.enabled('lsp.enabled'),
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },

  -- Bridge between mason and lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    enabled = features.enabled('lsp.enabled'),
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls', 'omnisharp', 'cssls', 'dockerls',
          'docker_compose_language_service', 'eslint', 'graphql', 'html',
          'helm_ls', 'jsonls', 'ts_ls', 'lua_ls', 'marksman',
          'pylsp', 'rust_analyzer', 'sqls', 'svelte', 'taplo',
          'terraformls', 'tflint', 'lemminx', 'yamlls', 'emmet_ls',
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP engine
  {
    'neovim/nvim-lspconfig',
    enabled = features.enabled('lsp.enabled'),
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('lsp-config')
    end,
  },

  -- Enhanced LSP UI (hover, rename, finder, code actions, outline)
  {
    'nvimdev/lspsaga.nvim',
    enabled = features.enabled('lspsaga'),
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lspsaga-config')
    end,
  },

  -- Dedicated formatter (prettier, black, stylua, etc.)
  {
    'stevearc/conform.nvim',
    enabled = features.enabled('conform'),
    event = 'BufWritePre',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'black' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          json = { 'prettier' },
          css = { 'prettier' },
          html = { 'prettier' },
          markdown = { 'prettier' },
          svelte = { 'prettier' },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Per-project LSP config overrides via .neoconf.json
  {
    'folke/neoconf.nvim',
    enabled = features.enabled('neoconf'),
    -- Must load before lspconfig
    priority = 100,
    config = function()
      require('neoconf').setup()
    end,
  },
}
