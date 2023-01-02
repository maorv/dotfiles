-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- Indent line
  use 'lukas-reineke/indent-blankline.nvim'

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Tag viewer
  use 'liuchengxu/vista.vim'

  -- Treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  -- Color schemes
  use 'navarasu/onedark.nvim'

  use 'tanvirtin/monokai.nvim'

  use { 'rose-pine/neovim', as = 'rose-pine' }

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    },
  }

  -- Statusline
  use {
    'famiu/feline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  use {"ellisonleao/glow.nvim"}

  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'lewis6991/spellsitter.nvim',
  }

  -- git interface
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup()
    end
  }

  use { 'tamago324/lir.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- git plugin
  use {
  'tanvirtin/vgit.nvim',
   requires = 'nvim-lua/plenary.nvim',
  }

end)
