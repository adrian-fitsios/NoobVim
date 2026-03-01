-- nvim-treesitter v1.0: complete incompatible rewrite of the plugin.
-- require('nvim-treesitter.configs') no longer exists.
-- Highlighting is automatic once a parser is installed (:TSInstall / :TSUpdate).
-- The installer runs :TSUpdateSync to pre-install parsers.

require('nvim-treesitter').setup()

-- nvim-ts-autotag is now standalone — no longer wired through nvim-treesitter.
require('nvim-ts-autotag').setup()
