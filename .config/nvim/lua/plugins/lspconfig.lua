-- ~/nvim/lua/slydragonn/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local nvim_lsp = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    local protocol = require("vim.lsp.protocol")

    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function()
            local file_extension = vim.fn.expand("%:e")
            if file_extension ~= "py" then
              vim.lsp.buf.format()
            end
          end,
        })
      end
      -- Mappings.
      local opts = { noremap = true, silent = true }
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup_handlers({
      function(server)
        nvim_lsp[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["ts_ls"] = function()
        nvim_lsp["ts_ls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["gopls"] = function()
        nvim_lsp["gopls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            gopls = {
              buildFlags = { "-tags=integration" }, -- Set your Go build tags here
            },
          },

        })
      end,
      ["clangd"] = function()
        nvim_lsp["clangd"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["bashls"] = function()
        nvim_lsp["bashls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
      ["pyright"] = function()
        nvim_lsp["pyright"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  end,
}
