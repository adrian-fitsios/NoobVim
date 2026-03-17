local M = {}

local config_path = vim.fn.stdpath('config') .. '/config.json'
local config = { features = {} }

local function load_config()
  local file = io.open(config_path, 'r')
  if not file then
    vim.notify('[feature-loader] config.json not found at ' .. config_path, vim.log.levels.WARN)
    return
  end
  local content = file:read('*all')
  file:close()
  local ok, parsed = pcall(vim.fn.json_decode, content)
  if ok and type(parsed) == 'table' then
    config = parsed
  else
    vim.notify('[feature-loader] Failed to parse config.json', vim.log.levels.ERROR)
  end
end

load_config()

-- Check if a feature is enabled.
-- Nested features use dot notation: "lsp.enabled", "dap.python"
-- Returns true if not explicitly set to false (opt-out model).
function M.enabled(feature)
  local parts = vim.split(feature, '.', { plain = true })
  local current = config.features or {}
  for _, part in ipairs(parts) do
    if type(current) ~= 'table' then return false end
    current = current[part]
    if current == nil then return true end
  end
  if type(current) == 'boolean' then return current end
  if type(current) == 'table' then return current.enabled ~= false end
  return true
end

-- Get the raw value of a feature config node (for non-boolean settings).
function M.get(feature)
  local parts = vim.split(feature, '.', { plain = true })
  local current = config.features or {}
  for _, part in ipairs(parts) do
    if type(current) ~= 'table' then return nil end
    current = current[part]
  end
  return current
end

return M
