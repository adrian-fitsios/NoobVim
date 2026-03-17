local features = require('feature-loader')

return {
  -- direnv integration: re-applies .envrc on buffer switch so LSP sees
  -- the correct interpreter when working across monorepo sub-projects.
  -- Requires direnv to be installed (brew install direnv / apt install direnv).
  {
    'actionshrimp/direnv.nvim',
    enabled = features.enabled('direnv'),
    config = function()
      require('direnv-nvim').setup({})
    end,
  },
}
