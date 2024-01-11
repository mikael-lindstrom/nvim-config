return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'zbirenbaum/copilot-cmp',
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            -- Enable LSP snippets
            snippet = {
                expand = function(args) require('luasnip').lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            -- Installed sources
            sources = {
                { name = 'copilot', group_index = 2 },
                { name = 'nvim_lsp', group_index = 2 },
                { name = 'buffer', group_index = 2 },
            },
        })
    end,
}
