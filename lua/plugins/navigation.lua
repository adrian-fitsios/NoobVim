local features = require('feature-loader')

return {
  -- Fuzzy finder + extensions
  {
    'nvim-telescope/telescope.nvim',
    enabled = features.enabled('telescope'),
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      'cljoly/telescope-repo.nvim',
      'AckslD/nvim-neoclip.lua',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
      require('telescope-config')
    end,
  },

  -- Find & replace in files
  {
    'MagicDuck/grug-far.nvim',
    enabled = features.enabled('grug_far'),
    config = function()
      require('grug-far-config')
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    enabled = features.enabled('nvim_tree'),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree-config')
    end,
  },
}
