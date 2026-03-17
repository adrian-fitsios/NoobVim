local features = require('feature-loader')

return {
  -- Autocompletion engine
  {
    'hrsh7th/nvim-cmp',
    enabled = features.enabled('completion'),
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('nvim-cmp-config')
    end,
  },

  -- Snippet engine (required by nvim-cmp)
  {
    'L3MON4D3/LuaSnip',
    enabled = features.enabled('completion'),
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
    config = function()
      require('luasnip-config')
    end,
  },

  -- Auto-close brackets/quotes
  {
    'windwp/nvim-autopairs',
    enabled = features.enabled('completion'),
    event = 'InsertEnter',
    config = function()
      require('autopairs-config')
    end,
  },
}
