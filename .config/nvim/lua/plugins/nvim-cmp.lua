local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "zbirenbaum/copilot.lua", -- Add Copilot.lua
    "zbirenbaum/copilot-cmp", -- Add Copilot-cmp
  },
}

M.config = function()
  local cmp = require("cmp")
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  local kind_icons = {
    Text = "T ",
    Method = "M ",
    Function = "ƒ ",
    Constructor = " ",
    Field = "f ",
    Variable = "x ",
    Constant = "c ",
    Class = "C ",
    Interface = "I ",
    Struct = "S ",
    Enum = "E ",
    EnumMember = "e ",
    Module = "M",
    Property = " ",
    Unit = "U ",
    Value = "V ",
    Keyword = "K ",
    Snippet = " ",
    File = " ",
    Folder = " ",
    Color = " ",
    Copilot = "ai ",
  }

  -- Setup copilot.lua
  require("copilot").setup({
    suggestion = { enabled = false }, -- Disable Copilot's inline suggestions
    panel = { enabled = false },      -- Disable Copilot's panel
    autostart = true,                 -- Enable autostart
    filetypes = {
      cpp = true,                     -- Enable Copilot for C++
      go = true,                      -- Enable Copilot for Go
      python = true,                  -- Enable Copilot for Python
      ["*"] = false,                  -- Disable Copilot for all other file types
    },
  })

  -- Setup copilot-cmp
  require("copilot_cmp").setup()

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" }, -- For luasnip users.
      { name = "copilot" }, -- Add Copilot as a source
    }, {
      { name = "buffer" },
      { name = "path" },
    }),

    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[NvimAPI]",
          path = "[Path]",
          copilot = "[Copilot]", -- Add Copilot to the source menu
        })[entry.source.name]
        return vim_item
      end,
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return M
