-- builtin nvim configurations
require('hotkeys')
vim.o.number = true
vim.opt.list = true
vim.g.loaded_matchparen = 1
vim.o.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.swapfile = false
--vim.opt.guicursor = ''

-- vim.opt.listchars = { space = '·', tab = '└─┘' }
-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins

require("lazy").setup({
  "nvie/vim-flake8",
  "lukas-reineke/indent-blankline.nvim",
  'jakewvincent/mkdnflow.nvim',
  'dense-analysis/ale',
  '0styx0/abbreinder.nvim',
  'iamcco/markdown-preview.nvim',
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  'ekickx/clipboard-image.nvim',
  'jubnzv/mdeval.nvim',
  'jbyuki/venn.nvim',
  'NFrid/due.nvim',
  'jbyuki/nabla.nvim',
  'rktjmp/lush.nvim',
  'rebelot/kanagawa.nvim',
  'nvim-treesitter/nvim-treesitter',
  {"nvim-neo-tree/neo-tree.nvim",
  dependencies = 
  {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  }
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = { enabled = false }
  },
  {'renerocksai/telekasten.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-lua/popup.nvim',
    }},
})

require('telekasten').setup({
  home = vim.fn.expand("~/vault"),
})


require("indent_blankline").setup {
 char = '┆',
}

require("hardtime").setup()
require('mkdnflow').setup()
vim.cmd("colorscheme kanagawa")

require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "python", "markdown" },
  auto_install = true,
  highlight = { enable = true },
}

vim.g.ale_linters = {
    c = {'gcc'},
}
