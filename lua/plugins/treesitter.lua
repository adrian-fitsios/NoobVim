local features = require('feature-loader')

return {
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = features.enabled('treesitter'),
    lazy = false,  -- nvim-treesitter v1.0 does not support lazy-loading
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('tree-sitter-config')
    end,
  },
}
