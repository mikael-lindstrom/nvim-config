return {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
        ensure_installed = {
            'lua_ls',
            'jsonnet_ls',
            'terraformls',
            'rust_analyzer',
            'gopls',
            'shfmt',
        },
    },
}
