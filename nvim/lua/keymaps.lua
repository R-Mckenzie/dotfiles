local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ","

-- Block arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- remap jk to escape
map('i', 'jk', '<Esc>')

-- Clear highlighting
map('n', '<leader><space>', ':nohl<CR>')

-- Navigate splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

--------------------
-- Plugin Keymaps --
--------------------

-- Diagnostics
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- Telescope
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- Nvim lsp
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

-- tagbar
map('n', '<leader>t', ":TagbarToggle<cr>")

-- vimwiki
map('n', '<leader>w', ":VimwikiIndex<cr>")

map('n', '<leader>e', ":NvimTreeToggle<cr>")
