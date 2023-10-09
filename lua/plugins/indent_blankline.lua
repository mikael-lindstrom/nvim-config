return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        require('ibl').setup({
            exclude = {
                buftypes = {
                    'nofile',
                    'terminal',
                },
                filetypes = {
                    'jsonnet',
                    'libsonnet',
                },
            },
        })
    end,
}
