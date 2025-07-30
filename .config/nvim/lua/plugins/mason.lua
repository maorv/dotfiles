-- ~/nvim/lua/slydragonn/plugins/mason.lua
return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- Configure diagnostics
        vim.diagnostic.config({
            virtual_text = {
                prefix = '●',
                source = "if_many",
            },
            float = {
                source = "always",
                border = "rounded",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        require("mason").setup()
        
        -- Mason 2.1+ approach - just ensure installation, no automatic setup
        require("mason-lspconfig").setup({
            ensure_installed = {
                "cssls",
                "eslint",
                "html", 
                "jsonls",
                "ts_ls",
                "pyright",
                "tailwindcss",
                "gopls",
                "jqls",
                "clangd",
                "rust_analyzer",
                "lua_ls",
                "bashls",
            },
        })
        
        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "stylua",
                "isort",
                "black",
                "pylint",
                "eslint_d",
            },
        })
        
        -- Manual LSP configuration using vim.lsp.config (Mason 2.1+ way)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        
        local on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, opts)
        end
        
        -- Mason 2.1+ LSP Configuration using vim.lsp.config
        -- Python - Pyright
        vim.lsp.config.pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pyright = {
                    disableOrganizeImports = false,
                    disableLanguageServices = false,
                },
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                    },
                },
            },
        }
        
        -- Lua
        vim.lsp.config.lua_ls = {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    diagnostics = { globals = {'vim'} },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        }
        
        -- TypeScript/JavaScript
        vim.lsp.config.ts_ls = {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
        }
        
        -- Go
        vim.lsp.config.gopls = {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                gopls = {
                    buildFlags = { "-tags=integration" },
                    completeUnimported = true,
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        }
        
        -- Rust
        vim.lsp.config.rust_analyzer = {
            cmd = { "rust-analyzer" },
            filetypes = { "rust" },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = { command = "clippy" },
                    procMacro = { enable = true },
                    cargo = { allFeatures = true },
                },
            },
        }
        
        -- C/C++
        vim.lsp.config.clangd = {
            cmd = { "clangd", "--background-index", "--clang-tidy" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        
        -- Bash
        vim.lsp.config.bashls = {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        
        -- HTML
        vim.lsp.config.html = {
            cmd = { "vscode-html-language-server", "--stdio" },
            filetypes = { "html" },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        
        -- CSS
        vim.lsp.config.cssls = {
            cmd = { "vscode-css-language-server", "--stdio" },
            filetypes = { "css", "scss", "less" },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        
        -- JSON
        vim.lsp.config.jsonls = {
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json", "jsonc" },
            on_attach = on_attach,
            capabilities = capabilities,
        }
        
    end,
}
