return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    opts = {
        suggestions = { enabled = false },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
}
