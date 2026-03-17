local toggleterm = require('toggleterm')
local Terminal = require('toggleterm.terminal').Terminal

toggleterm.setup({
  hide_numbers = false,
  start_in_insert = true,
  direction = 'horizontal',
  size = 15,
})

-- Terminal 1 — bottom, full width
local term1 = Terminal:new({ id = 1, direction = 'horizontal' })

-- Terminal 2 — opens next to terminal 1 (vertical split within the bottom area)
local term2 = Terminal:new({ id = 2, direction = 'horizontal' })

function _G.toggle_term1()
  term1:toggle()
end

function _G.toggle_term2()
  -- If term2 is already visible, close it
  if term2.window ~= nil and vim.api.nvim_win_is_valid(term2.window) then
    term2:close()
    return
  end
  -- Ensure term1 is open (the anchor for the bottom bar)
  if term1.window == nil or not vim.api.nvim_win_is_valid(term1.window) then
    term1:open()
  end
  -- Focus term1's window so the vsplit lands next to it
  vim.api.nvim_set_current_win(term1.window)
  term2:open()
end

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- Exit terminal mode to normal mode
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- Window navigation from inside terminal
  vim.api.nvim_buf_set_keymap(0, 't', '<c-h>', [[<c-\><c-n><c-w>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-j>', [[<c-\><c-n><c-w>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-k>', [[<c-\><c-n><c-w>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-l>', [[<c-\><c-n><c-w>l]], opts)
  -- Toggle terminals from inside terminal mode (so the same key closes them)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-;>', [[<cmd>lua toggle_term1()<cr>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', "<A-'>", [[<cmd>lua toggle_term2()<cr>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
