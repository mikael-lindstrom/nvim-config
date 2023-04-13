return {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
        {
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason-lspconfig.nvim',
        },
    },
    config = function()
        local lsp_config = require('lspconfig')
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local on_attach = function(_, bufnr)
            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local nmap = function(keys, func, desc)
                if desc then desc = 'LSP: ' .. desc end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end
            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            nmap('<leader>li', '<cmd>LspInfo<cr>', 'LSP info')
            nmap('<leader>lI', '<cmd>NullLsInfo<cr>', 'Null-ls info')
            nmap('<leader>ld', function() vim.diagnostic.open_float({ border = 'rounded' }) end, 'Hover diagnostics')
        end

        lsp_config.util.default_config = vim.tbl_extend('force', lsp_config.util.default_config, {
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
        })

        lsp_config.terraformls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
                experimentalFeatures = {
                    validateOnSave = false,
                    prefillRequiredFields = true,
                },
            },
        })

        lsp_config.jsonnet_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lsp_config.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' },
        })

        lsp_config.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lsp_config.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        },
                    },
                },
            },
        })
    end,
}
