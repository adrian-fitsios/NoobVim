local grug_far = require('grug-far')

grug_far.setup({
  headerMaxWidth = 80,
  startInInsertMode = false,
  windowCreationCommand = 'vsplit',
  engines = {
    ripgrep = {
      extraArgs = '',
    },
  },
  keymaps = {
    close = { n = '<Esc>' },
  },
})

local _hidden = false

local M = {}

function M.open()
  grug_far.open({ instanceName = 'main' })
end

function M.open_with_word()
  grug_far.open({ prefills = { search = vim.fn.expand('<cword>') }, instanceName = 'main' })
end

function M.open_with_selection()
  grug_far.with_visual_selection({ instanceName = 'main' })
end

function M.toggle_hidden()
  _hidden = not _hidden
  local instance = grug_far.get_instance('main')
  if instance and instance:is_open() then
    instance:fill({ flags = _hidden and '--hidden' or '' })
  end
  vim.notify('grug-far: hidden files ' .. (_hidden and 'ON' or 'OFF'), vim.log.levels.INFO)
end

return M
