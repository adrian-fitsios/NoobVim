local features = require('feature-loader')

return {
  -- Git signs in sign column + hunk operations
  {
    'lewis6991/gitsigns.nvim',
    enabled = features.enabled('gitsigns'),
    config = function()
      require('gitsigns-config')
    end,
  },

  -- Inline conflict resolution
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    enabled = features.enabled('git_conflict'),
    config = function()
      require('git-conflict-config')
    end,
  },

  -- Full diff viewer, file history, merge conflict tool
  {
    'sindrets/diffview.nvim',
    enabled = features.enabled('diffview'),
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('diffview-config')
    end,
  },
}
