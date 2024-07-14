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
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function() require('neo-tree.command').execute({ action = 'close' }) end,
                },
                {
                    event = 'neo_tree_popup_input_ready',
                    handler = function(args)
                        vim.cmd('stopinsert')
                        vim.keymap.set('i', '<esc>', vim.cmd.stopinsert, { noremap = true, buffer = args.bufnr })
                    end,
                },
            },
        })
    end,
}
