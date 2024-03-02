return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
        },
        cmdline = {
            view = 'cmdline',
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'written',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'yanked',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'fewer line',
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'more line',
                },
                opts = { skip = true },
            },
        },
    },
    keys = {
        {
            '<c-f>',
            function()
                if not require('noice.lsp').scroll(4) then return '<c-f>' end
            end,
            silent = true,
            expr = true,
            desc = 'Scroll forward',
            mode = { 'i', 'n', 's' },
        },
        {
            '<c-b>',
            function()
                if not require('noice.lsp').scroll(-4) then return '<c-b>' end
            end,
            silent = true,
            expr = true,
            desc = 'Scroll backward',
            mode = { 'i', 'n', 's' },
        },
    },
}
