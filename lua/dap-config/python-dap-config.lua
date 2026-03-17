-- Use vim.fn.stdpath to get the correct mason data path on all platforms
local path_to_debugpy = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'

require('dap-python').setup(path_to_debugpy)
require('dap').configurations['python'] = {
  {
    type = 'python',
    request = 'launch',
    name = 'Vanilla python',
    program = '${file}',
    cwd = '${workspaceFolder}',
  },
}
