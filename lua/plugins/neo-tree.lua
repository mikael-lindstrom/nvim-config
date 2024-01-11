return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
    },
    keys = {
        { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    config = function()
        require('neo-tree').setup({
            enable_normal_mode_for_inputs = true,
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function() require('neo-tree.command').execute({ action = 'close' }) end,
                },
            },
        })
    end,
}
