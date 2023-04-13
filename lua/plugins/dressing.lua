return {
    'stevearc/dressing.nvim',
    config = function()
        require('dressing').setup({
            input = {
                win_options = { winhighlight = 'Normal:Normal,NormalNC:Normal' },
            },
            select = {
                backend = { 'telescope', 'builtin' },
                builtin = { win_options = { winhighlight = 'Normal:Normal,NormalNC:Normal' } },
            },
        })
    end,
}
