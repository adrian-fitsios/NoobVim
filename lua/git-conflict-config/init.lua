require('git-conflict').setup({
  default_mappings = false,
  disable_diagnostics = true,
  highlights = {
    incoming = 'DiffAdd',
    current  = 'DiffText',
  },
})
