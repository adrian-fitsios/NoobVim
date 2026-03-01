require('dashboard').setup({
  theme = 'doom',
  config = {
    header = {
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[`MM\     `M'                    MM     `Mb(     )d' 68b                 ]],
      [[ MMM\     M                     MM      YM.     ,P  Y89                 ]],
      [[ M\MM\    M   _____     _____   MM____  `Mb     d'  ___ ___  __    __   ]],
      [[ M \MM\   M  6MMMMMb   6MMMMMb  MMMMMMb  YM.   ,P   `MM `MM 6MMb  6MMb  ]],
      [[ M  \MM\  M 6M'   `Mb 6M'   `Mb MM'  `Mb `Mb   d'    MM  MM69 `MM69 `Mb ]],
      [[ M   \MM\ M MM     MM MM     MM MM    MM  YM. ,P     MM  MM'   MM'   MM ]],
      [[ M    \MM\M MM     MM MM     MM MM    MM  `Mb d'     MM  MM    MM    MM ]],
      [[ M     \MMM MM     MM MM     MM MM    MM   YM,P      MM  MM    MM    MM ]],
      [[ M      \MM YM.   ,M9 YM.   ,M9 MM.  ,M9   `MM'      MM  MM    MM    MM ]],
      [[_M_      \M  YMMMMM9   YMMMMM9 _MYMMMM9     YP      _MM__MM_  _MM_  _MM_]],
      [[]],
      [[]],
      [[]],
      [[]],
      [[]],
    },
    center = {
      {
        icon = "   ",
        icon_hl = 'Title',
        desc = "Recently opened files",
        desc_hl = 'String',
        key = "r",
        key_hl = 'Number',
        action = "Telescope oldfiles",
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Open a git project',
        desc_hl = 'String',
        key = 'p',
        key_hl = 'Number',
        action = 'Telescope repo list'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Open a file',
        desc_hl = 'String',
        key = 'f',
        key_hl = 'Number',
        keymap = 'Ctrl + p',
        action = 'Telescope find_files find_command=rg,--hidden,--files'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Open file tree',
        desc_hl = 'String',
        key = 't',
        key_hl = 'Number',
        keymap = 'Alt+b',
        action = 'NvimTreeOpen'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Refresh your memory (see shortcuts)',
        desc_hl = 'String',
        key = ' ',
        key_hl = 'Number',
        keymap = 'Space',
        action = 'WhichKey'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Find a word anywhere',
        desc_hl = 'String',
        key = 'w',
        key_hl = 'Number',
        keymap = 'Ctrl + Shift + f',
        action = 'Telescope live_grep'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Update packages',
        desc_hl = 'String',
        key = 'u',
        key_hl = 'Number',
        action = 'Lazy sync'
      },
      {
        icon = '   ',
        icon_hl = 'Title',
        desc = 'Exit',
        desc_hl = 'String',
        key = 'x',
        keymap = 'ESC',
        key_hl = 'Number',
        action = 'qall'
      }
    },
    footer = { 'Nvim config for beginners' }
  }
})
