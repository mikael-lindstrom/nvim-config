-- Autoformat on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.tf', '*.tfvars', '*.jsonnet', '*.libsonnet', '*.lua', '*.rs', '*.go', '*.sh' },
    command = 'lua vim.lsp.buf.format()',
})
