return {
    'nvim-treesitter/nvim-treesitter',
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    event = { 'BufRead', 'BufEnter' },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = 'all',
            sync_install = false,

            ignore_install = { 'phpdoc' },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>',
                },
            },
        })
    end,
}
