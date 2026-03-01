local features = require('feature-loader')

return {
  -- Colour scheme
  {
    'EdenEast/nightfox.nvim',
    enabled = features.enabled('colorscheme'),
    lazy = false,
    priority = 1000,
    config = function()
      require('color-schemes')
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    enabled = features.enabled('lualine'),
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'dracula' },
      })
    end,
  },

  -- Buffer tabs (replaces barbar.nvim)
  {
    'akinsho/bufferline.nvim',
    enabled = features.enabled('bufferline'),
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline-config')
    end,
  },

  -- File icons (shared dependency)
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },

  -- Startup dashboard
  {
    'nvimdev/dashboard-nvim',
    enabled = features.enabled('dashboard'),
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard-config')
    end,
  },

  -- Session save/restore
  {
    'folke/persistence.nvim',
    enabled = features.enabled('sessions'),
    event = 'BufReadPre',
    config = function()
      require('persistence').setup()
    end,
  },

  -- Lua utility functions (required by many plugins)
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
}
