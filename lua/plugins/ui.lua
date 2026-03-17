local features = require('feature-loader')

return {
  -- Keybinding discovery popup
  {
    'folke/which-key.nvim',
    enabled = features.enabled('which_key'),
    event = 'VeryLazy',
    config = function()
      require('whichkey-config')
    end,
  },

  -- Clipboard history via telescope
  {
    'AckslD/nvim-neoclip.lua',
    enabled = features.enabled('neoclip'),
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('neoclip-config')
    end,
  },

  -- In-editor markdown preview
  {
    'ellisonleao/glow.nvim',
    enabled = features.enabled('glow'),
    config = function()
      require('glow').setup()
    end,
  },

  -- Code commenting (gcc / gc)
  {
    'numToStr/Comment.nvim',
    enabled = features.enabled('comment'),
    config = function()
      require('Comment').setup()
    end,
  },

  -- Project-wide diagnostics panel
  {
    'folke/trouble.nvim',
    enabled = features.enabled('trouble'),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup()
    end,
  },

  -- TODO/FIXME/HACK highlights + telescope search
  {
    'folke/todo-comments.nvim',
    enabled = features.enabled('todo_comments'),
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup()
    end,
  },
}
