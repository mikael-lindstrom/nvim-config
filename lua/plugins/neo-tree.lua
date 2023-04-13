return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
        { '<leader>o', '<cmd>Neotree focus<cr>', desc = 'NeoTree' },
    },
    config = function() require('neo-tree').setup() end,
}
