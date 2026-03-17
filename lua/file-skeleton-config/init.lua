local utils = require('lua-utils')

local M = {}

local function get_path_to_skeleton_directory()
  local directory_of_current_file = debug.getinfo(2, "S").source:sub(2):match("(.*/)")
  return directory_of_current_file .. "skeletons"
end

local function get_skeleton_file_contents(extension)
  local path_to_skeleton_file = get_path_to_skeleton_directory() .. "/" .. extension .. ".skeleton"

  local skeleton_file = io.open(path_to_skeleton_file, "rb")
  if (skeleton_file ~= nil) then
    return skeleton_file:read("*all")
  end
  print("[file-skeleton-config] there was a problem loading skeleton file contents for '" .. extension .. "' extension.")
  return ""
end

local function insert_dynamic_values(skeleton_file_contents, newly_created_file_path)
  local pattern = "%${FILE_NAME}"
  local file_name = utils.get_file_name(newly_created_file_path)
  local result = string.gsub(skeleton_file_contents, pattern, file_name)

  return result
end

function M.insert_skeleton(file_path)
  local extensions = utils.get_file_extension(file_path)
  local extension = table.concat(extensions, ".")

  local supported_extensions = utils.list_dir(get_path_to_skeleton_directory())
  if not utils.has_value(supported_extensions, extension .. ".skeleton") then
    return
  end

  local newly_created_file = io.open(file_path, "w")
  if (newly_created_file ~= nil) then
    local skeleton_file_contents = get_skeleton_file_contents(extension)
    newly_created_file:write(insert_dynamic_values(skeleton_file_contents, file_path))
    newly_created_file:close()
  end
end

return M
