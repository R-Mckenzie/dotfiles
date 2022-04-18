vim.api.nvim_exec([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting()]], false)

vim.api.nvim_set_keymap('n', '<leader>gt', ':!go test<CR>', { noremap = true })
