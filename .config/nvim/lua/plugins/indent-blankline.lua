-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- url: https://github.com/lukas-reineke/indent-blankline.nvim


require('ibl').setup {
  indent = {
    char = " "
  },
  exclude = {
    filetypes = {
      'help',
      'git',
      'markdown',
      'text',
      'terminal',
      'lspinfo',
      'packer',
    },
    buftypes = {
      'terminal',
      'nofile',
    }
  }
}
