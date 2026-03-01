local features = require('feature-loader')

return {
  -- Integrated terminal (two floating terminals)
  {
    'akinsho/toggleterm.nvim',
    enabled = features.enabled('toggleterm'),
    version = '*',
    config = function()
      require('toggle-term-config')
    end,
  },

  -- One-key code runner (F5)
  {
    'CRAG666/code_runner.nvim',
    enabled = features.enabled('code_runner'),
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('code_runner').setup({
        mode = 'term',
        focus = false,
        filetype = {
          java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
          python = 'python3 -u',
          typescript = 'node $file',
          javascript = 'node $file',
          rust = 'cd $dir && rustc $fileName && $dir/$fileNameWithoutExt',
        },
      })
    end,
  },
}
