-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Settings must be loaded first so leader key is set before lazy processes keymaps
require('settings')

-- Setup lazy.nvim — scans lua/plugins/*.lua for plugin specs
require('lazy').setup('plugins', {
  checker = { enabled = false },
  change_detection = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
  },
})

-- Global state used by nvim-tree auto-open logic
vim.g.noobvim_tree_was_shown = false
