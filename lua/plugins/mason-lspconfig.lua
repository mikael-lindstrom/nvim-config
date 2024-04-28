return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        {
            'williamboman/mason.nvim',
        },
    },
    opts = {
        ensure_installed = {
            'lua_ls',
            'jsonnet_ls',
            'terraformls',
            'rust_analyzer',
            'gopls',
            'templ',
            'html',
            'htmx',
            'tailwindcss',
        },
    },
}
