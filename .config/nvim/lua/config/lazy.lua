-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({

  spec = {
    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", colorscheme="onedark", },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- Autopair
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Icons
  "kyazdani42/nvim-web-devicons",

  -- Tag viewer
  "liuchengxu/vista.vim",

  "tanvirtin/monokai.nvim",

  -- Dashboard (start screen)
  {
    "goolord/alpha-nvim",
    dependecies = { "kyazdani42/nvim-web-devicons" },
  },

  { "ellisonleao/glow.nvim" },

  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependecies = { "kyazdani42/nvim-web-devicons" },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "lewis6991/spellsitter.nvim",
  },

  "nvim-lua/plenary.nvim",
  -- git interface
  {
    "TimUntersberger/neogit",
    dependecies = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup()
    end,
  },

  { "tamago324/lir.nvim",   dependecies = { "nvim-lua/plenary.nvim" } },

  -- git plugin
  {
    "tanvirtin/vgit.nvim",
    dependecies = "nvim-lua/plenary.nvim",
  },

  { "zbirenbaum/copilot.lua" },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    build = "make tiktoken",        -- Only on MacOS or Linux
    opts = {
      debug = true,                 -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

})
