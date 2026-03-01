require('bufferline').setup({
  options = {
    numbers = 'ordinal',
    close_command = 'bd %d',
    right_mouse_command = 'bd %d',
    left_mouse_command = 'buffer %d',
    indicator = { style = 'icon', icon = '▎' },
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_at_end',
    -- Offset for nvim-tree panel
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'left',
        separator = true,
      },
    },
  },
})
