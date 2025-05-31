{
    pkgs,
    lib,
    ...
}: {
    programs = {
        neovim = {
            enable = true;
            defaultEditor = true;
            extraLuaConfig = ''
                for option, value in pairs {
                    clipboard = "unnamedplus",
                    termguicolors = true,
                    tabstop = 4,
                    shiftwidth = 4,
                    expandtab = true,
                    number = true,
                    cursorline = true,
                    shortmess = "IF",
                    showmode = false,
                    laststatus = 0
                } do
                    vim.opt[option] = value
                end

                vim.g.mapleader = " "  
            ''; 
            plugins = with lib.utils.neovim; mkLuaConfig (with pkgs; with vimPlugins; let
                treesitter-nvim = nvim-treesitter.withPlugins (plugins: with plugins; with tree-sitter-grammars; [
                    c
                    cpp
                    zig
                    lua
                    python
                    javascript
                    typescript
                    css
                    scss
                    nix
                    tree-sitter-norg
                    tree-sitter-norg-meta
                ]);
                treesitter-parsers = symlinkJoin {
                    name = "treesitter-parsers";
                    paths = treesitter-nvim.dependencies;
                };
                live-rename-nvim = mkPluginFromGitHub {
                    owner = "saecki";
                    repo = "live-rename.nvim";
                    rev = "3fcc9dc66b3c32a9e312d40f41afab300f265a4b";
                    sha256 = "sha256-L0ViOLwvxYEyi1cbViFH520/GwTKxGHUEzmH0ulmK3U=";
                }; 
                lua-utils-nvim = mkPluginFromLuaPackage {
                    package = "lua-utils-nvim";
                };
                pathlib-nvim = mkPluginFromLuaPackage {
                    package = "pathlib-nvim";
                };
            in [
                {
                    plugin = lazy-nvim;
                    config = ''
                        require("lazy").setup({
                            pkg = {
                                enabled = false
                            },
                            install = {
                                missing = false
                            },
                            checker = {
                                enabled = false
                            },
                            rocks = {
                                enabled = false
                            },
                            spec = {
                                {
                                    dir = "${catppuccin-nvim}",
                                    name = "catppuccin.nvim",
                                    lazy = false,
                                    priority = 1000,
                                    config = function()
                                        require("catppuccin").setup({
                                            flavour = "frappe"
                                        })
                                        vim.cmd.colorscheme("catppuccin")
                                    end
                                },
                                {
                                    dir = "${treesitter-nvim}",
                                    name = "treesitter.nvim",
                                    event = {
                                        "BufReadPre",
                                        "BufNewFile"
                                    },
                                    dependencies = {
                                        {
                                            dir = "${nvim-treesitter-context}",
                                            name = "treesitter-context.nvim",
                                            config = function()
                                                require'treesitter-context'.setup({
                                                    enable = false
                                                })
                                                for highlight, link in pairs({
                                                    TreesitterContext = "None",
                                                    TreesitterContextLineNumber = "None"
                                                }) do
                                                    vim.api.nvim_set_hl(0, highlight, { link = link })
                                                end
                                                vim.api.nvim_create_autocmd("FileType", {
                                                    callback = function(event)
                                                        local bufnr = event.buf
                                                        local filetype = vim.bo[bufnr].filetype
                                                        local parsers = require("nvim-treesitter.parsers")

                                                        if parsers.has_parser(filetype) then
                                                            local keymaps = { 
                                                                { mode = "n", bind = "<leader>tt", cmd = "<cmd>TSContextToggle<cr>", description = "Treesitter toggle context" },
                                                                { mode = "n", bind = "<leader>tj", cmd = function() require("treesitter-context").go_to_context(vim.v.count1) end, description = "Treesitter jump to context" },
                                                            }
                                                            for _, keymap in ipairs(keymaps) do
                                                                vim.keymap.set(keymap.mode, keymap.bind, keymap.cmd, { desc = keymap.description, buffer = bufnr, noremap = true, silent = true })
                                                            end
                                                        end
                                                    end,
                                                })
                                            end
                                        }
                                    },
                                    config = function()
                                        vim.opt.runtimepath:append("${treesitter-parsers}")
                                        require'nvim-treesitter.configs'.setup({
                                            auto_install = false,
                                            highlight = {
                                                enable = true
                                            },
                                            indent = {
                                                enable = true
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${nvim-lspconfig}",
                                    name = "lspconfig.nvim",
                                    lazy = false,
                                    config = function()
                                        vim.diagnostic.config({
                                            virtual_lines = {
                                                only_current_line = false,
                                                format = function(diagnostic)
                                                    local signs = {
                                                        ERROR = " ",
                                                        WARN = " ",
                                                        INFO = " ",
                                                        HINT = " "
                                                    }
                                                    return signs[vim.diagnostic.severity[diagnostic.severity]] .. diagnostic.message
                                                end
                                            },
                                            signs = false
                                        })

                                        local servers = {
                                            clangd = { },
                                            zls = { },
                                            pyright = { },
                                            lua_ls = {
                                                settings = {
                                                    Lua = {
                                                        telemetry = {
                                                            enable = false
                                                        },
                                                        workspace = {
                                                            library = { },
                                                            checkThirdParty = false
                                                        }
                                                    }
                                                }
                                            },
                                            ts_ls = { },
                                            cssls = { },
                                            nil_ls = { }
                                        }
                                        local function on_attach(client, bufnr)
                                            if client.server_capabilities.inlayHintProvider then
                                                vim.lsp.inlay_hint.enable(bufnr, true)
                                            end

                                            local keymaps = {
                                                { mode = "n", bind = "<leader>lo", command = vim.lsp.buf.declaration, description = "LSP declaration" },
                                                { mode = "n", bind = "<leader>ld", command = vim.lsp.buf.definition, description = "LSP definition" },
                                                { mode = "n", bind = "<leader>li", command = vim.lsp.buf.implementation, description = "LSP implementation" },
                                                { mode = "n", bind = "<leader>lh", command = vim.lsp.buf.hover, description = "LSP hover" },
                                                { mode = "n", bind = "<leader>lr", command = function() require("live-rename").rename() end, description = "LSP rename" },
                                            }
                                            for _, keymap in ipairs(keymaps) do
                                                vim.keymap.set(keymap.mode, keymap.bind, keymap.command, { desc = keymap.description, buffer = bufnr, noremap = true, silent = true })
                                            end
                                        end

                                        for server, opts in pairs(servers) do
                                            opts.on_attach = on_attach
                                            vim.lsp.config(server, opts)
                                            vim.lsp.enable(server)
                                        end
                                    end
                                },
                                {
                                    dir = "${tiny-devicons-auto-colors-nvim}",
                                    name = "tiny-devicons-auto-colors.nvim",
                                    event = "VeryLazy",
                                    dependencies = {
                                        {
                                            dir = "${nvim-web-devicons}",
                                            name = "web-devicons-nvim"
                                        }
                                    },
                                    config = function()
                                        require('tiny-devicons-auto-colors').setup({
                                            factors = {
                                                lightness = 1.75,
                                                chroma = 1,
                                                hue = 1.25
                                            },
                                            precise_search = {
                                                enabled = true,
                                                iteration = 10,
                                                precision = 20,
                                                threshold = 23
                                            },
                                            cache = {
                                                enabled = true
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${noice-nvim}",
                                    name = "noice.nvim",
                                    lazy = false,
                                    dependencies = {
                                        {
                                            dir = "${nui-nvim}",
                                            name = "nui.nvim"
                                        }
                                    },
                                    config = function()
                                        require("noice").setup({
                                            views = {
                                                notify = {
                                                    replace = true
                                                }
                                            },
                                            lsp = {
                                                progress = {
                                                    view = "notify"
                                                },
                                                signature = {
                                                    enabled = false
                                                },
                                                documentation = {
                                                    opts = {
                                                        border = {
                                                            style = "rounded"
                                                        },
                                                        win_options = {
                                                            winhighlight = "Normal:None"
                                                        }
                                                    }
                                                },
                                                override = {
                                                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                                                    ["vim.lsp.util.stylize_markdown"] = true
                                                }
                                            },
                                            presets = {
                                                bottom_search = false,
                                                command_palette = true,
                                                long_message_to_split = true,
                                                lsp_doc_border = true
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${which-key-nvim}",
                                    name = "which-key.nvim",
                                    lazy = false,
                                    config = function()
                                        require("which-key").setup({
                                            preset = "helix",
                                            plugins = {
                                                marks = false,
                                                registers = false,
                                                spelling = {
                                                    enabled = false
                                                }
                                            },
                                            icons = {
                                                group = " ",
                                                mappings = false,
                                                keys = {
                                                    Up = "",
                                                    Down = "",
                                                    Left = "",
                                                    Right = "",
                                                    C = "󰘴",
                                                    M = "󰘵",
                                                    D = "󰘳",
                                                    S = "󰘶",
                                                    CR = "󰌑",
                                                    Esc = "󱊷",
                                                    ScrollWheelDown = "󱕐",
                                                    ScrollWheelUp = "󱕑",
                                                    NL = "󰌑",
                                                    BS = "󰁮",
                                                    Space = "󱁐",
                                                    Tab = "󰌒",
                                                    F1 = "󱊫",
                                                    F2 = "󱊬",
                                                    F3 = "󱊭",
                                                    F4 = "󱊮",
                                                    F5 = "󱊯",
                                                    F6 = "󱊰",
                                                    F7 = "󱊱",
                                                    F8 = "󱊲",
                                                    F9 = "󱊳",
                                                    F10 = "󱊴",
                                                    F11 = "󱊵",
                                                    F12 = "󱊶"
                                                }
                                            }
                                        })
                                        vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "None" })
                                    end
                                },
                                {
                                    dir = "${snacks-nvim}",
                                    name = "snacks.nvim",
                                    lazy = false,
                                    keys = {
                                        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find file" },
                                        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent file" },
                                        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find with grep" },
                                    },
                                    config = function()
                                        require("snacks").setup({
                                            animate = {
                                                fps = 60
                                            },
                                            bigfile = {
                                                enabled = true
                                            },
                                            notifier = {
                                                enabled = true,
                                                style = "compact",
                                                icons = {
                                                    error = "",
                                                    warn = "",
                                                    info = "",
                                                    debug = "󰃤",
                                                    trace = ""
                                                }
                                            },
                                            indent = {
                                                enabled = true, 
                                                scope = {
                                                    enabled = true,
                                                    only_current = false
                                                },
                                                chunk = {
                                                    enabled = true,
                                                    only_current = false,
                                                    char = {
                                                        corner_top = "╭",
                                                        corner_bottom = "╰",
                                                        arrow = ""
                                                    }
                                                },
                                                animate = {
                                                    enabled = true
                                                }
                                            },
                                            picker = {
                                                enabled = true,
                                                prompt = " ❯ "
                                            },
                                        })
                                    end
                                },
                                {
                                    dir = "${lualine-nvim}",
                                    name = "lualine.nvim",
                                    lazy = false,
                                    config = function()
                                        require('lualine').setup({
                                            options = {
                                                globalstatus = true,
                                                section_separators = {
                                                    left = "",
                                                    right = ""
                                                },
                                                component_separators = {
                                                    left = "",
                                                    right = ""
                                                },
                                                theme = "catppuccin"
                                            },
                                            tabline = {
                                                lualine_a = {
                                                    {
                                                        "buffers",
                                                        show_filename_only = true,
                                                        hide_filename_extension = true,
                                                        mode = 0,
                                                        use_mode_colors = true,
                                                        buffers_color = {
                                                            inactive = "lualine_b_normal"
                                                        },
                                                        symbols = {
                                                            modified = " 󰛿",
                                                            alternate_file = "",
                                                            directory = "󰉋"
                                                        },
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    }
                                                }
                                            },
                                            sections = {
                                                lualine_a = {
                                                    {
                                                        "mode",
                                                        icon = "",
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    }
                                                },
                                                lualine_b = {
                                                    {
                                                        "branch",
                                                        icon = "",
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    },
                                                    {
                                                        "diff",
                                                        symbols = {
                                                            added = "󰐗 ",
                                                            modified = "󰛿 ",
                                                            removed = "󰍶 "
                                                        },
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    }
                                                },
                                                lualine_c = { },
                                                lualine_x = { },
                                                lualine_y = {
                                                    {
                                                        "diagnostics",
                                                        symbols = {
                                                            error = " ",
                                                            warn = " ",
                                                            info = " ",
                                                            hint = " ",
                                                        },
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    }
                                                },
                                                lualine_z = {
                                                    {
                                                        "location",
                                                        icon = "",
                                                        separator = {
                                                            left = "",
                                                            right = ""
                                                        }
                                                    }
                                                }
                                            },
                                            inactive_sections = {
                                                lualine_a = { },
                                                lualine_b = { },
                                                lualine_c = { },
                                                lualine_x = { },
                                                lualine_y = { },
                                                lualine_z = { }
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${nvim-autopairs}",
                                    name = "autopairs.nvim",
                                    event = "InsertEnter",
                                    config = function()
                                        require("nvim-autopairs").setup()
                                    end
                                },
                                {
                                    dir = "${mini-comment}",
                                    name = "mini-comment.nvim",
                                    event = {
                                        "BufReadPre",
                                        "BufNewFile"
                                    },
                                    config = function()
                                        require("mini.comment").setup({
                                            mappings = {
                                                comment = "",
                                                comment_line = "<leader>cc",
                                                comment_visual = "<leader>cs",
                                                textobject = ""
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${live-rename-nvim}",
                                    name = "live-rename.nvim",
                                    event = "LspAttach",
                                    config = function()
                                        require("live-rename").setup({
                                            keys = {
                                                submit = {
                                                    { "n", "<cr>" },
                                                    { "v", "<cr>" },
                                                    { "i", "<cr>" }
                                                },
                                                cancel = {
                                                    { "n", "<esc>" }
                                                }
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${luasnip}",
                                    name = "luasnip.nvim",
                                    dependencies = {
                                        {
                                            dir = "${friendly-snippets}",
                                            name = "friendly-snippets.nvim"
                                        }
                                    },
                                    event = "InsertEnter",
                                    config = function()
                                        require("luasnip.loaders.from_vscode").lazy_load()
                                    end
                                },
                                {
                                    dir = "${blink-cmp}",
                                    name = "blink-cmp.nvim",
                                    event = "InsertEnter",
                                    config = function()
                                        require('blink.cmp').setup({
                                            appearance = {
                                                nerd_font_variant = "mono"
                                            },
                                            completion = {
                                                menu = {
                                                    auto_show = true,
                                                    draw = {
                                                        columns = {
                                                            { "label" },
                                                            { "kind_icon", "kind", gap = 1 }
                                                        },
                                                        treesitter = {
                                                            "lsp"
                                                        }
                                                    },
                                                    border = "rounded",
                                                    winhighlight = "Normal:None"
                                                },
                                                list = {
                                                    selection = {
                                                        preselect = false,
                                                        auto_insert = false
                                                    }
                                                },
                                                documentation = {
                                                    auto_show = true,
                                                    window = {
                                                        border = "rounded",
                                                        winhighlight = "Normal:None"
                                                    }
                                                },
                                            },
                                            signature = {
                                                enabled = true,
                                                window = {
                                                    border = "rounded",
                                                    winhighlight = "Normal:None"
                                                }
                                            },
                                            snippets = {
                                                preset = "luasnip"
                                            },
                                            sources = {
                                                default = {
                                                    "lsp",
                                                    "path",
                                                    "snippets",
                                                    "buffer"
                                                }
                                            },
                                            keymap = {
                                                preset = "none",
                                                ["<C-c>"] = {
                                                    "show",
                                                    "hide"
                                                },
                                                ["<C-d>"] = {
                                                    "show_documentation",
                                                    "hide_documentation"
                                                },
                                                ["<C-s>"] = {
                                                    "show_signature",
                                                    "hide_signature"
                                                },
                                                ["<C-up>"] = {
                                                    "select_prev"
                                                },
                                                ["<C-down>"] = {
                                                    "select_next"
                                                },
                                                ["<C-left>"] = {
                                                    "scroll_documentation_up"
                                                },
                                                ["<C-right>"] = {
                                                    "scroll_documentation_down"
                                                },
                                                ["<C-a>"] = {
                                                    "select_and_accept"
                                                }
                                            }
                                        })
                                    end
                                },
                                {
                                    dir = "${neorg}",
                                    name = "neorg.nvim",
                                    dependencies = {
                                        {
                                            dir = "${lua-utils-nvim}",
                                            name = "lua-utils.nvim"
                                        },
                                        {
                                            dir = "${pathlib-nvim}",
                                            name = "pathlib.nvim"
                                        },
                                        {
                                            dir = "${nvim-nio}",
                                            name = "nio.nvim"
                                        }
                                    },
                                    ft = "norg",
                                    config = function()
                                        require("neorg").setup({
                                            load = {
                                                ["core.defaults"] = { },
                                                ["core.keybinds"] = {
                                                    config = {
                                                        default_keybinds = false
                                                    }
                                                },
                                                ["core.concealer"] = { },
                                            }
                                        })
                                    end
                                }
                            }
                        })
                    '';
                }
            ]);
            extraPackages = with pkgs; [
                zig
                clang-tools
                zls
                lua-language-server
                pyright
                typescript-language-server
                vscode-langservers-extracted
                nil
                imagemagick
                ghostscript
            ];
        };
    };
}
