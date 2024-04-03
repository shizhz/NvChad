vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Create a link from nvconfig.lua to chadrc.lua to make nvchad ui plugins happy
local cfg_path = vim.fn.stdpath "config"
local nvconfig = cfg_path .. "lua/nvconfig.lua"
if not vim.loop.fs_stat(nvconfig) then
  vim.fn.system {"ln", "-s", cfg_path .. "/chadrc.lua", cfg_path .. "/nvconfig.lua"}
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "nvchad.configs.lazy_nvim"

require("nvchad.options")
-- load plugins
require("lazy").setup({
  {import = "nvchad.plugins"}
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "nvchad.mappings"
end)
