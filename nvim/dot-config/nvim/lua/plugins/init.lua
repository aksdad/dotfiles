-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Function to load all plugin files in the `plugins` directory except `init.lua`
local function load_plugins()
  local plugins = {}
  local plugin_dir = vim.fn.stdpath 'config' .. '/lua/plugins'
  for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
    if file ~= 'init.lua' and file:match '%.lua$' then
      local plugin_module = 'plugins.' .. file:gsub('%.lua$', '')
      local ok, spec = pcall(require, plugin_module)
      if ok then
        vim.list_extend(plugins, spec)
      else
        vim.notify('Error loading ' .. plugin_module .. ': ' .. spec, vim.log.levels.ERROR)
      end
    end
  end
  return plugins
end

require('lazy').setup(load_plugins(), {
  ui = {
    icons = {},
  },
})
