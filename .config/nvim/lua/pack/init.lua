---@class Plugin
---@field spec? (string|vim.pack.Spec)[]
---@field setup? fun()

local M = {}

---@param spec string|vim.pack.Spec
---@return string?
local function source(spec) return type(spec) == 'string' and spec or spec.src end

---@param specs (string|vim.pack.Spec)[]
function M.add(specs) vim.pack.add(specs) end

---@param names string[]
function M.load_all(names)
  local modules, specs, seen = {}, {}, {}

  for _, name in ipairs(names) do
    ---@type Plugin
    local plugin = require('plugins.' .. name)
    modules[#modules + 1] = plugin

    for _, spec in ipairs(plugin.spec or {}) do
      local key = source(spec)
      if key and not seen[key] then
        seen[key] = true
        specs[#specs + 1] = spec
      end
    end
  end

  M.add(specs)
  for _, plugin in ipairs(modules) do
    if plugin.setup then plugin.setup() end
  end
end

return M
