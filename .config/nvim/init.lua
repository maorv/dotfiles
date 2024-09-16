--[[

Neovim init file
Version: 0.51.0 - 2022/03/25
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua

--]]

require("config.lazy")
-- Import Lua modules
require('core/settings')
require('core/keymaps')
-- require('core/colors')
-- require('core/statusline')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<c-B>',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })
