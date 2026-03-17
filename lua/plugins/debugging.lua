local features = require('feature-loader')

return {
  {
    'mfussenegger/nvim-dap',
    enabled = features.enabled('dap.enabled'),
    dependencies = {
      -- DAP UI
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        config = function()
          require('dap-config/dap-ui-config')
        end,
      },
      -- Inline variable values during debug
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function()
          require('nvim-dap-virtual-text').setup({})
        end,
      },
      -- Python debugger
      {
        'mfussenegger/nvim-dap-python',
        enabled = features.enabled('dap.python'),
        config = function()
          require('dap-config/python-dap-config')
        end,
      },
      -- JS/TS debugger
      {
        'mxsdev/nvim-dap-vscode-js',
        enabled = features.enabled('dap.javascript'),
        config = function()
          require('dap-config/js-dap-config')
        end,
      },
      -- Telescope DAP integration
      {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
      },
    },
  },
}
