local present, impatient = pcall(require, "impatient")

if present then
   impatient.enable_profile()
end

require "core"
require "core.utils"
require "core.options"

vim.defer_fn(function()
   require("core.utils").load_mappings()
end, 0)

-- setup packer + plugins
require("core.packer").bootstrap()
require "plugins"

local user_conf, _ = pcall(require, "custom")

if user_conf then
   require "custom"
end

-- Keybindings
-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", ",<C-l>", ":nohlsearch<CR>", { silent = true })
