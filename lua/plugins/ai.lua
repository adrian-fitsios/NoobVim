local features = require('feature-loader')

return {
  -- AI chat + inline edits (Claude via Anthropic API)
  -- Set ANTHROPIC_API_KEY in your shell environment to use.
  {
    'olimorris/codecompanion.nvim',
    enabled = features.enabled('codecompanion'),
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup({
        strategies = {
          chat = { adapter = 'anthropic' },
          inline = { adapter = 'anthropic' },
        },
      })
    end,
  },
}
