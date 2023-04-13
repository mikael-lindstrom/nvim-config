return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
        require('indent_blankline').setup({
            use_treesitter = true,
            buftype_exclude = {
                'nofile',
                'terminal',
            },
            filetype_exclude = {
                'jsonnet',
                'libsonnet',
            },
        })
    end,
}
