require('config.lazy')
require('config.colorscheme')
require('config.autocommands')
require('config.keymaps')
require('config.commands')

-- Allow local overrides of the config: per machine and per project.
local function path_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function find_upward(name, start_dir)
  local dir = vim.fs.normalize(start_dir)
  local candidate = vim.fs.joinpath(dir, name)
  if path_exists(candidate) then
    return candidate
  end

  local parent = vim.fs.dirname(dir)
  if parent == nil or parent == dir then
    return nil
  end

  return find_upward(name, parent)
end

local function load_local_nvim_config(path)
  vim.opt.runtimepath:append(path)
  local init_path = vim.fs.joinpath(path, "init.lua")
  if path_exists(init_path) then
    dofile(init_path)
  end
end

local machine_config_path = vim.fs.joinpath(vim.fn.stdpath("config"), "local")
if path_exists(machine_config_path) then
  load_local_nvim_config(machine_config_path)
end

local project_config_path = find_upward(".nvim", vim.fn.getcwd())
if project_config_path ~= nil and path_exists(project_config_path) then
  load_local_nvim_config(project_config_path)
end
