vim.api.nvim_exec([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting()]], false)
