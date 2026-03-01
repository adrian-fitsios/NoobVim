local nt_api = require('nvim-tree.api')
local file_skeleton_utils = require('file-skeleton-config')

-- Replace rm -rf with the safe vim.fn.delete (works cross-platform)
local function bulk_delete()
  local marked_files = nt_api.marks.list()
  for _, node in pairs(marked_files) do
    vim.fn.delete(node.absolute_path, 'rf')
  end
  nt_api.marks.clear()
  nt_api.tree.reload()
end

local function setup_key_mapping(bufnr)
  local function map(key, action, desc)
    vim.keymap.set('n', key, action, { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc })
  end

  local function lmap(key, action, desc)
    vim.keymap.set('n', '<leader>' .. key, action,
      { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = desc })
  end

  -- File operations
  map('o', nt_api.node.open.edit, 'Open file/directory')
  map('<CR>', nt_api.node.open.edit, 'Open file/directory')
  map('<2-LeftMouse>', nt_api.node.open.edit, 'Open file/directory')
  map('l', nt_api.node.open.edit, 'Open file/directory')
  map('<C-t>', nt_api.node.open.tab, 'Open file in new tab')
  map('v', nt_api.node.open.vertical, 'Open file in vertical split')
  map('a', nt_api.fs.create, 'Add a file or directory/')
  map('d', nt_api.fs.remove, 'Delete a file or directory')
  map('D', nt_api.fs.trash, 'Trash a file')
  map('r', nt_api.fs.rename, 'Rename a file')
  map('c', nt_api.fs.copy.node, 'Copy a file')
  map('y', nt_api.fs.copy.filename, "Yank a file's name")
  map('Y', nt_api.fs.copy.relative_path, "Yank a file's relative path")
  map('Ya', nt_api.fs.copy.absolute_path, "Yank a file's absolute path")
  map('p', nt_api.fs.paste, 'Paste')
  map('q', nt_api.tree.close, 'Close file tree')
  map('m', nt_api.marks.toggle, 'Mark a file for moving')
  map('bm', nt_api.marks.bulk.move, 'Move marked files')
  map('bd', bulk_delete, 'Delete marked files')

  -- Navigation
  lmap('gd', nt_api.tree.change_root_to_node, 'Change root to directory under cursor')
  lmap('gp', nt_api.node.navigate.parent, 'Move cursor to parent directory')
end

local function open_nvim_tree(data)
  local ignored_file_types = { 'dashboard', 'DiffviewFiles' }

  local real_file = vim.fn.filereadable(data.file) == 1
  local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
  local file_type = vim.bo[data.buf].ft

  if vim.g.noobvim_tree_was_shown then return end
  if not real_file and no_name then return end
  if vim.tbl_contains(ignored_file_types, file_type) then return end

  nt_api.tree.toggle({ focus = false, find_file = true })
  vim.g.noobvim_tree_was_shown = true
end

require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  on_attach = setup_key_mapping,
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
    show_on_dirs = true,
  },
  sort_by = 'case_sensitive',
  view = {
    width = 30,
    number = false,
    relativenumber = false,
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = '●',
          staged = 'S',
          ignored = '󰗹',
          deleted = 'D',
          untracked = '●',
          renamed = '➜',
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
  },
})

require('nvim-web-devicons').setup({ default = true })

vim.api.nvim_create_autocmd({ 'BufAdd' }, { callback = open_nvim_tree })

nt_api.events.subscribe(nt_api.events.Event.FileCreated, function(data)
  file_skeleton_utils.insert_skeleton(data.fname)
end)
