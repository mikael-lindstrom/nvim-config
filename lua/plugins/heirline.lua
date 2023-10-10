return {
    'rebelot/heirline.nvim',
    event = 'UiEnter',
    config = function()
        local utils = require('heirline.utils')
        local conditions = require('heirline.conditions')

        -- Setup colors
        local colors = require('gruvbox').palette
        require('heirline').load_colors(colors)

        local Space = { provider = ' ' }

        local Align = { provider = '%=' }

        local Cap = { provider = '▌' }

        local Mode
        do
            local ReadOnly = {
                condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
                provider = '',
                hl = { fg = 'bright_red' },
            }

            local Circle = {
                provider = '',
                hl = { fg = 'dark1' },
            }

            Mode = {
                init = function(self)
                    self.mode = vim.fn.mode(1)
                    self.mode_name = self.mode_names[self.mode]
                    self.mode_label = self.mode_labels[self.mode_name]
                    self.mode_color = self.mode_colors[self.mode_name]
                end,
                static = {
                    mode_names = {
                        n = 'normal',
                        no = 'op',
                        nov = 'op',
                        noV = 'op',
                        ['no'] = 'op',
                        niI = 'normal',
                        niR = 'normal',
                        niV = 'normal',
                        nt = 'normal',
                        v = 'visual',
                        V = 'visual_lines',
                        [''] = 'visual_block',
                        s = 'select',
                        S = 'select',
                        [''] = 'block',
                        i = 'insert',
                        ic = 'insert',
                        ix = 'insert',
                        R = 'replace',
                        Rc = 'replace',
                        Rv = 'v_replace',
                        Rx = 'replace',
                        c = 'command',
                        cv = 'command',
                        ce = 'command',
                        r = 'enter',
                        rm = 'more',
                        ['r?'] = 'confirm',
                        ['!'] = 'shell',
                        t = 'terminal',
                        ['null'] = 'none',
                    },
                    mode_colors = {
                        normal = 'light1',
                        op = 'bright_blue',
                        insert = 'bright_blue',
                        visual = 'bright_yellow',
                        visual_lines = 'bright_yellow',
                        visual_block = 'bright_yellow',
                        block = 'bright_yellow',
                        replace = 'bright_red',
                        v_replace = 'bright_red',
                        select = 'bright_purple',
                        command = 'bright_aqua',
                        enter = 'bright_aqua',
                        more = 'bright_aqua',
                        confirm = 'bright_red',
                        shell = 'bright_orange',
                        terminal = 'bright_orange',
                        none = 'bright_red',
                    },
                    mode_labels = {
                        normal = 'NORMAL',
                        op = 'OP',
                        visual = 'VISUAL',
                        visual_lines = 'VISUAL LINES',
                        visual_block = 'VISUAL BLOCK',
                        select = 'SELECT',
                        block = 'BLOCK',
                        insert = 'INSERT',
                        replace = 'REPLACE',
                        v_replace = 'V-REPLACE',
                        command = 'COMMAND',
                        enter = 'ENTER',
                        more = 'MORE',
                        confirm = 'CONFIRM',
                        shell = 'SHELL',
                        terminal = 'TERMINAL',
                        none = 'NONE',
                    },
                },
                hl = { bg = 'dark2' },
                update = {
                    'ModeChanged',
                    pattern = '*:*',
                    callback = vim.schedule_wrap(function() vim.cmd('redrawstatus') end),
                },
                {
                    utils.surround({ ' ', ' ' }, function(self) return self.mode_color end, {
                        {
                            fallthrough = false,
                            ReadOnly,
                            Circle,
                        },
                        Space,
                        {
                            provider = function(self) return self.mode_label end,
                            hl = { fg = 'dark1', bold = true },
                        },
                    }),
                },
            }
        end

        local FileNameBlock
        do
            local FileIcon = {
                init = function(self)
                    local extension = vim.fn.fnamemodify(self.buf_name, ':e')
                    self.icon, self.icon_color =
                        require('nvim-web-devicons').get_icon_color(self.buf_name, extension, { default = true })
                end,
                provider = function(self) return self.icon and (self.icon .. ' ') end,
                hl = function(self) return { fg = self.icon_color, bg = 'dark2' } end,
            }

            local Path = {
                provider = function(self)
                    self.path = vim.fn.fnamemodify(self.buf_name, ':~:.:h')
                    if self.path == '.' then
                        self.path = ''
                    else
                        self.path = self.path .. '/'
                    end
                end,
                hl = { fg = 'grey', bg = 'dark2' },
                flexible = 10,
                { provider = function(self) return self.path end },
                { provider = function(self) return vim.fn.pathshorten(self.path) end },
                { provider = '' },
            }

            local FileName = {
                provider = function(self)
                    local filename = vim.fn.fnamemodify(self.buf_name, ':t')
                    if filename == '' then return '[No Name]' end
                    return filename
                end,
            }

            local FileFlags = {
                {
                    condition = function() return vim.bo.modified end,
                    provider = '[+]',
                    hl = { fg = 'bright_green' },
                },
            }

            FileNameBlock = {
                init = function(self)
                    self.buf_name = vim.api.nvim_buf_get_name(0)
                    self.filename = vim.fn.fnamemodify(self.buf_name, ':t')
                end,
                FileIcon,
                Path,
                FileName,
                FileFlags,
                { provider = '%<' },
            }
        end

        local Lsp = {
            condition = conditions.lsp_attached,
            update = { 'LspAttach', 'LspDetach' },
            provider = function()
                local names = {}
                local null_ls = false
                for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                    if server.name == 'null-ls' then
                        null_ls = true
                    else
                        table.insert(names, server.name)
                    end
                end
                if null_ls then
                    local sources = require('null-ls.sources')
                    for _, server in pairs(sources.get_available(vim.bo.filetype)) do
                        table.insert(names, server.name)
                    end
                end
                return ' [' .. table.concat(names, ' ') .. ']'
            end,
        }

        local Ruler = {
            -- :help 'statusline'
            -- ------------------
            -- %-2 : make item takes at least 2 cells and be left justified
            -- %l  : current line number
            -- %L  : number of lines in the buffer
            -- %c  : column number
            -- %V  : virtual column number as -{num}.  Not displayed if equal to '%c'.
            provider = ' %9(%l:%L%)  %-3(%c%V%) ',
        }

        local ScrollPercentage = {
            provider = ' %3(%P%) ',
        }

        require('heirline').setup({
            statusline = {
                Cap,
                Mode,
                FileNameBlock,
                Align,
                Lsp,
                Ruler,
                ScrollPercentage,
                Cap,
            },
        })
    end,
}
