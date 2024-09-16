return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "tomasiser/vim-code-dark",
    lazy = true,
    config = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme("codedark")
    end,
  },
}
