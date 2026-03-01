local actions = require('diffview.actions')

-- Helper: set buffer-local keymaps for diffview panels
local function map_buf(bufnr, key, action, desc)
  vim.keymap.set('n', key, action, { buffer = bufnr, noremap = true, silent = true, desc = desc })
end

local function map_leader(bufnr, key, action, desc)
  vim.keymap.set('n', '<leader>' .. key, action, { buffer = bufnr, noremap = true, silent = true, desc = desc })
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = 'DiffviewFilePanel',
  callback = function(ctx)
    local b = ctx.buf
    -- Navigation
    map_buf(b, '<tab>', actions.select_next_entry, 'Next file diff')
    map_buf(b, '<s-tab>', actions.select_prev_entry, 'Previous file diff')
    map_buf(b, '<cr>', actions.select_entry, 'Open diff for selected entry')
    map_buf(b, 'j', actions.next_entry, 'Next file entry')
    map_buf(b, 'k', actions.prev_entry, 'Previous file entry')
    map_buf(b, 'o', actions.select_entry, 'Open diff for selected entry')
    -- Actions
    map_buf(b, 'X', actions.restore_entry, 'Restore entry to left-side state')
    map_buf(b, 'R', actions.refresh_files, 'Refresh file list')
    map_buf(b, 'L', actions.open_commit_log, 'Open commit log panel')
    map_buf(b, 't', actions.listing_style, "Toggle 'list'/'tree' view")
    map_buf(b, 'f', actions.toggle_flatten_dirs, 'Flatten empty subdirectories')
    -- Leader
    map_leader(b, 'gf', actions.goto_file_tab, 'Open file in new tabpage')
    map_leader(b, 'hs', actions.toggle_stage_entry, 'Stage/unstage selected entry')
    map_leader(b, 'hS', actions.stage_all, 'Stage all entries')
    map_leader(b, 'hU', actions.unstage_all, 'Unstage all entries')
    map_buf(b, '<Esc>', actions.close, 'Close diffview')
  end,
})

require('diffview').setup({
  diff_binaries = false,
  enhanced_diff_hl = false,
  git_cmd = { 'git' },
  use_icons = true,
  icons = {
    folder_closed = '',
    folder_open = '',
  },
  signs = {
    fold_closed = '',
    fold_open = '',
    done = '✓',
  },
  view = {
    default = {
      layout = 'diff2_horizontal',
      winbar_info = true,
    },
    merge_tool = {
      layout = 'diff3_horizontal',
      disable_diagnostics = true,
      winbar_info = true,
    },
    file_history = {
      layout = 'diff2_horizontal',
      winbar_info = false,
    },
  },
  file_panel = {
    listing_style = 'tree',
    tree_options = {
      flatten_dirs = true,
      folder_statuses = 'only_folded',
    },
    win_config = {
      position = 'left',
      width = 35,
      win_opts = {},
    },
  },
  file_history_panel = {
    log_options = {
      git = {
        single_file = { diff_merges = 'combined' },
        multi_file = { diff_merges = 'first-parent' },
      },
    },
    win_config = {
      position = 'bottom',
      height = 16,
      win_opts = {},
    },
  },
  commit_log_panel = {
    win_config = { win_opts = {} },
  },
  default_args = {
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {
    diff_buf_read = function(bufnr)
      -- Navigation
      map_buf(bufnr, '<tab>', actions.select_next_entry, 'Next file diff')
      map_buf(bufnr, '<s-tab>', actions.select_prev_entry, 'Previous file diff')
      map_buf(bufnr, '[c', actions.prev_conflict, 'Previous conflict')
      map_buf(bufnr, ']c', actions.next_conflict, 'Next conflict')
      -- Leader: conflict resolution
      map_leader(bufnr, 'gf', actions.goto_file_tab, 'Open file in new split')
      map_leader(bufnr, 'co', actions.conflict_choose('ours'), 'Choose OURS version')
      map_leader(bufnr, 'ct', actions.conflict_choose('theirs'), 'Choose THEIRS version')
      map_leader(bufnr, 'cb', actions.conflict_choose('base'), 'Choose BASE version')
      map_leader(bufnr, 'ca', actions.conflict_choose('all'), 'Choose ALL versions')
      map_leader(bufnr, 'cd', actions.conflict_choose('none'), 'Delete conflict region')
      map_buf(bufnr, '<Esc>', actions.close, 'Close diffview')
    end,
  },
  keymaps = {
    disable_defaults = true,
    diff1 = {},
    diff2 = {},
    diff3 = {
      { { 'n', 'x' }, '2do', actions.diffget('ours') },
      { { 'n', 'x' }, '3do', actions.diffget('theirs') },
    },
    diff4 = {
      { { 'n', 'x' }, '1do', actions.diffget('base') },
      { { 'n', 'x' }, '2do', actions.diffget('ours') },
      { { 'n', 'x' }, '3do', actions.diffget('theirs') },
    },
    file_history_panel = {
      ['g!'] = actions.options,
      ['<C-A-d>'] = actions.open_in_diffview,
      ['y'] = actions.copy_hash,
      ['L'] = actions.open_commit_log,
      ['zR'] = actions.open_all_folds,
      ['zM'] = actions.close_all_folds,
      ['j'] = actions.next_entry,
      ['<down>'] = actions.next_entry,
      ['k'] = actions.prev_entry,
      ['<up>'] = actions.prev_entry,
      ['<cr>'] = actions.select_entry,
      ['o'] = actions.select_entry,
      ['<2-LeftMouse>'] = actions.select_entry,
      ['<c-b>'] = actions.scroll_view(-0.25),
      ['<c-f>'] = actions.scroll_view(0.25),
      ['<tab>'] = actions.select_next_entry,
      ['<s-tab>'] = actions.select_prev_entry,
      ['gf'] = actions.goto_file,
      ['<C-w><C-f>'] = actions.goto_file_split,
      ['<C-w>gf'] = actions.goto_file_tab,
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
      ['g<C-x>'] = actions.cycle_layout,
      ['<Esc>'] = actions.close,
    },
    option_panel = {
      ['<tab>'] = actions.select_entry,
      ['q'] = actions.close,
      ['<Esc>'] = actions.close,
    },
  },
})
