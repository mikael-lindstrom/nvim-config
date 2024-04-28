-- Autoformat on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.tf', '*.tfvars', '*.jsonnet', '*.libsonnet', '*.lua', '*.rs', '*.go', '*.sh' },
    command = 'lua vim.lsp.buf.format()',
})

-- templ files needs special handling since it will have multiple LSPs running
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.templ' },
    command = 'lua vim.lsp.buf.format({ filter = function(client) return client.name == "templ" end })',
})
