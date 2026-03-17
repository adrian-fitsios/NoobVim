-- Neovim 0.11+ LSP config: use vim.lsp.config / vim.lsp.enable instead of lspconfig.setup()
-- nvim-lspconfig still provides the per-server config files; we just enable/customise them.

-- Suppress terraformls noise about diffview:// virtual buffer URIs
local _orig_show_message = vim.lsp.handlers['window/showMessage']
vim.lsp.handlers['window/showMessage'] = function(err, result, ctx, config)
  if result and result.message and result.message:match('diffview://') then
    return
  end
  return _orig_show_message(err, result, ctx, config)
end

-- conform.nvim handles format-on-save; disable LSP formatting to avoid double-format.
local on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = false
end

-- Enhanced capabilities for snippet completion (required by nvim-cmp)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Apply capabilities + on_attach to every server via the wildcard config
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ── Server-specific overrides ─────────────────────────────────────────────────

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.config('omnisharp', {
  cmd = { 'dotnet', vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll' },
  enable_import_completion = true,
  organize_imports_on_format = true,
  enable_roslyn_analyzers = true,
  root_dir = function(fname)
    return vim.fs.root(fname, { '*.sln', '*.csproj', 'omnisharp.json', 'function.json', '.vsconfig' })
  end,
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100,
        },
      },
    },
  },
})

vim.lsp.config('emmet_ls', {
  filetypes = {
    'html', 'css', 'scss', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'svelte',
  },
})

vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
      },
    },
  },
})

-- ── Enable all servers ────────────────────────────────────────────────────────
vim.lsp.enable({
  'lua_ls', 'bashls', 'ts_ls', 'marksman', 'dockerls',
  'terraformls', 'jsonls', 'omnisharp', 'pylsp',
  'html', 'cssls', 'svelte', 'emmet_ls', 'yamlls',
})
