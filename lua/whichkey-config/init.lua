local wk = require('which-key')

wk.setup({
  preset = 'classic',
  delay = 300,
  win = {
    border = 'double',
  },
  layout = {
    spacing = 3,
    align = 'left',
  },
  icons = {
    separator = '➜',
    group = '+ ',
    breadcrumb = '»',
  },
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
    presets = {
      operators = false,
      motions = false,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
})

local telescope_api = require('telescope.builtin')
local gs = require('gitsigns')
local grug_far = require('grug-far-config')

function _G.close_buffer_smart()
  local buf = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })
  if #listed > 1 then
    vim.cmd('BufferLineCycleNext')
    vim.cmd('bd ' .. buf)
  else
    vim.cmd('bd')
  end
end

-- ── Leader mappings ───────────────────────────────────────────────────────────
wk.add({
  -- Groups
  { '<leader>h', group = 'Git hunks' },
  { '<leader>g', group = 'Go to' },
  { '<leader>c', group = 'Code' },
  { '<leader>s', group = 'Show' },
  { '<leader>i', group = 'Insert' },
  { '<leader>o', group = 'Open' },
  { '<leader>t', group = 'Trouble' },

  -- Git hunk operations
  { '<leader>hs', '<cmd>lua require("gitsigns").stage_hunk()<cr>', desc = 'Stage hunk' },
  { '<leader>hS', '<cmd>lua require("gitsigns").stage_buffer()<cr>', desc = 'Stage buffer' },
  { '<leader>hr', '<cmd>lua require("gitsigns").reset_hunk()<cr>', desc = 'Reset hunk' },
  { '<leader>hR', '<cmd>lua require("gitsigns").reset_buffer()<cr>', desc = 'Reset buffer' },
  { '<leader>hu', '<cmd>lua require("gitsigns").undo_stage_hunk()<cr>', desc = 'Undo stage hunk' },
  { '<leader>hp', '<cmd>lua require("gitsigns").preview_hunk()<cr>', desc = 'Preview hunk' },
  { '<leader>hd', '<cmd>lua require("gitsigns").diffthis()<cr>', desc = 'View diff of this file' },
  { '<leader>hD', '<cmd>DiffviewOpen<cr>', desc = 'Diff of the repo' },

  -- LSP navigation
  { '<leader>gd', '<cmd>Lspsaga peek_definition<cr>', desc = 'Peek definition' },
  { '<leader>gi', '<cmd>Lspsaga finder<cr>', desc = 'Find implementations/references' },

  -- Code
  { '<leader>ca', '<cmd>Lspsaga code_action<cr>', desc = 'Open code actions', mode = 'n' },

  -- Conflict resolution (git-conflict.nvim)
  { '<leader>co', '<cmd>GitConflictChooseOurs<cr>',   desc = 'Conflict: choose ours' },
  { '<leader>ct', '<cmd>GitConflictChooseTheirs<cr>', desc = 'Conflict: choose theirs' },
  { '<leader>cb', '<cmd>GitConflictChooseBoth<cr>',   desc = 'Conflict: choose both' },
  { '<leader>c0', '<cmd>GitConflictChooseNone<cr>',   desc = 'Conflict: reject both' },

  -- Show
  { '<leader>sd', '<cmd>Lspsaga show_line_diagnostics<cr>', desc = 'Show line diagnostics' },

  -- Insert
  { '<leader>ib', '<cmd>lua require("dap").toggle_breakpoint()<cr>', desc = 'Toggle breakpoint' },

  -- Format
  { '<leader>f', '<cmd>lua vim.lsp.buf.format()<cr>', desc = 'Format file' },

  -- Open
  { '<leader>oo', '<cmd>Lspsaga outline<cr>', desc = 'Toggle symbol outline' },

  -- Trouble (project-wide diagnostics)
  { '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Toggle diagnostics' },
  { '<leader>tT', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
  { '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Toggle symbols' },

  -- Find & replace
  { '<leader>r',  group = 'Replace' },
  { '<leader>rr', function() grug_far.open() end,             desc = 'Find & replace in project' },
  { '<leader>rw', function() grug_far.open_with_word() end,   desc = 'Replace word under cursor' },
  { '<leader>rh', function() grug_far.toggle_hidden() end,    desc = 'Toggle hidden files' },
})

-- Visual mode leader
wk.add({
  { '<leader>c',  group = 'Code',    mode = 'v' },
  { '<leader>ca', '<esc><cmd>Lspsaga code_action<cr>', desc = 'Code actions', mode = 'v' },
  { '<leader>r',  group = 'Replace', mode = 'v' },
  { '<leader>rr', function() grug_far.open_with_selection() end, desc = 'Find & replace selection', mode = 'v' },
})

-- ── Normal mode (no leader) ───────────────────────────────────────────────────
wk.add({
  -- LSP
  { 'R', '<cmd>Lspsaga rename<cr>', desc = 'Rename all occurrences' },
  { 'K', '<cmd>Lspsaga hover_doc<cr>', desc = 'Hover documentation' },

  -- Hunk navigation
  {
    '[[',
    function()
      if vim.wo.diff then return '[[' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end,
    expr = true, desc = 'Jump to previous hunk',
  },
  {
    ']]',
    function()
      if vim.wo.diff then return ']]' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end,
    expr = true, desc = 'Jump to next hunk',
  },
  { '[d', function() require('lspsaga.diagnostic'):goto_prev() end, desc = 'Previous diagnostic' },
  { ']d', function() require('lspsaga.diagnostic'):goto_next() end, desc = 'Next diagnostic' },
  { '[x', '<cmd>GitConflictPrevConflict<cr>', desc = 'Previous conflict' },
  { ']x', '<cmd>GitConflictNextConflict<cr>', desc = 'Next conflict' },

  -- Run / Debug (F-keys)
  -- F5 = run code, S-F5 = start/continue debugger
  { '<F5>', '<cmd>RunCode<cr>', desc = 'Run code' },
  { '<S-F5>', '<cmd>lua require("dap").continue()<cr>', desc = 'Start / continue debug' },
  { '<F10>', '<cmd>lua require("dap").step_over()<cr>', desc = 'Step over (debug)' },
  { '<F11>', '<cmd>lua require("dap").step_into()<cr>', desc = 'Step into (debug)' },
  { '<F12>', '<cmd>lua require("dap").step_out()<cr>', desc = 'Step out (debug)' },

  -- Search
  { '<C-p>', function() telescope_api.find_files({ hidden = true }) end, desc = 'Find files' },
  { '<C-f>', function() telescope_api.current_buffer_fuzzy_find() end, desc = 'Search in buffer' },
  { '<C-S-f>', function() telescope_api.live_grep() end, desc = 'Live grep (directory)' },

  -- Window navigation
  { '<C-h>', '<C-w>h', desc = 'Window left' },
  { '<C-k>', '<C-w>k', desc = 'Window above' },
  { '<C-j>', '<C-w>j', desc = 'Window below' },
  { '<C-l>', '<C-w>l', desc = 'Window right' },

  -- Buffer navigation (bufferline)
  { '<C-,>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
  { '<C-.>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  { '<C-S-w>', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close other buffers' },

  -- Go to buffer by number
  { '<A-1>', '<cmd>BufferLineGoToBuffer 1<cr>', desc = 'Go to buffer 1' },
  { '<A-2>', '<cmd>BufferLineGoToBuffer 2<cr>', desc = 'Go to buffer 2' },
  { '<A-3>', '<cmd>BufferLineGoToBuffer 3<cr>', desc = 'Go to buffer 3' },
  { '<A-4>', '<cmd>BufferLineGoToBuffer 4<cr>', desc = 'Go to buffer 4' },
  { '<A-5>', '<cmd>BufferLineGoToBuffer 5<cr>', desc = 'Go to buffer 5' },
  { '<A-6>', '<cmd>BufferLineGoToBuffer 6<cr>', desc = 'Go to buffer 6' },
  { '<A-7>', '<cmd>BufferLineGoToBuffer 7<cr>', desc = 'Go to buffer 7' },
  { '<A-8>', '<cmd>BufferLineGoToBuffer 8<cr>', desc = 'Go to buffer 8' },
  { '<A-9>', '<cmd>BufferLineGoToBuffer 9<cr>', desc = 'Go to buffer 9' },

  -- File tree
  { '<A-b>', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle file explorer' },

  -- Terminals
  { '<A-;>',  '<cmd>lua toggle_term1()<cr>', desc = 'Terminal 1' },
  { "<A-'>",  '<cmd>lua toggle_term2()<cr>', desc = 'Terminal 2' },
})

-- ── CodeCompanion (AI) ────────────────────────────────────────────────────────
wk.add({
  { '<leader>a',  group = 'AI' },
  { '<leader>ai', '<cmd>CodeCompanionActions<cr>',     desc = 'AI actions palette',   mode = { 'n', 'v' } },
  { '<leader>ak', '<cmd>CodeCompanion<cr>',            desc = 'AI inline assistant',  mode = { 'n', 'v' } },
  { '<leader>ac', '<cmd>CodeCompanionCmd<cr>',         desc = 'AI shell command',     mode = 'n' },
  { '<A-a>',      '<cmd>CodeCompanionChat toggle<cr>', desc = 'Toggle AI chat',       mode = 'n' },
  { '<A-l>',      '<cmd>CodeCompanionChat add<cr>',    desc = 'Send selection to AI', mode = 'v' },
})

-- ── All modes ─────────────────────────────────────────────────────────────────
wk.add({
  { '<C-s>', '<cmd>w<cr>', desc = 'Save', mode = { 'n', 'i', 'v' } },
  -- <C-w> closes buffer; window navigation uses <C-h/j/k/l> instead
  { '<C-w>', '<cmd>lua close_buffer_smart()<cr>', desc = 'Close buffer', mode = { 'n', 'i', 'v' } },
  { '<C-S-v>', '<cmd>Telescope neoclip<cr>', desc = 'Clipboard history', mode = { 'n', 'i', 'v' } },
  { '<A-p>', '<cmd>Glow %<cr>', desc = 'Preview markdown', mode = { 'n', 'i', 'v' } },
})
