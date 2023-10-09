return {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('telescope').setup() end,
    keys = {
        { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = 'Find recently opened files' },
        { '<leader><space>', '<cmd>Telescope buffers<cr>', desc = 'Find existing buffers' },
        { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Find files' },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help' },
        { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Find current word' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Find by grep' },
        { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Find diagnostics' },
        { '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Find in current buffer' },
    },
}
