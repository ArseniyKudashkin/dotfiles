--[[
lua/hotkeys.lua
lua/plugins.lua

Important notes.
For correct work vim-flake8 (python code linter), semshi (python code highlighting) need to install flake8, pynvim with pip3, 
after plugins installation type in neovim :UpdateRemotePlugins
]]

-- builtin nvim configurations
vim.o.number = true
vim.opt.list = true
vim.g.loaded_matchparen = 1
vim.o.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
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
  'ekickx/clipboard-image.nvim',
  'Wansmer/langmapper.nvim',
  'jubnzv/mdeval.nvim', -- eval code in md notes
  'jbyuki/venn.nvim', -- diagrams
  'NFrid/due.nvim', -- dead lines, time
  'jbyuki/nabla.nvim', -- latex in cli
  'rktjmp/lush.nvim', -- create neovim themes
  'rebelot/kanagawa.nvim',
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  'kwakzalver/duckytype.nvim',
  {'nagy135/typebreak.nvim',
  dependencies = 
  {
    'nvim-lua/plenary.nvim',
  },
  },
  'nvim-treesitter/nvim-treesitter',
  {"nvim-neo-tree/neo-tree.nvim",
  dependencies = 
  {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  }
},
{'renerocksai/telekasten.nvim',
dependencies = {
  'nvim-telescope/telescope.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope-media-files.nvim',
  'nvim-lua/popup.nvim',
}},
'davidgranstrom/nvim-markdown-preview',
})
require('telekasten').setup({
  home = vim.fn.expand("~/vault"),
})

require("indent_blankline").setup {
  char = '┆',
}

require('mkdnflow').setup({
  to_do = {
    symbols = { ' ', '-', 'x' },
  },
})
vim.cmd("colorscheme kanagawa")
require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "lua", "python", "latex", "markdown" },
  auto_install = false,
  highlight = { enable = true },
}

vim.g.ale_linters = {
  c = {'gcc'},
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
  end,
  })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt.colorcolumn = "79"
    vim.opt.shiftwidth = 8
    vim.opt.tabstop = 8
    vim.bo.expandtab = true
    vim.opt.softtabstop = 8
  end,
  })


require('duckytype').setup{}
require('todo-comments').setup{}
vim.keymap.set('n', '<leader>tb', require('typebreak').start, { desc = "Typebreak" })
local map = vim.keymap.set
map({''}, '<Leader>b', '<Cmd>Neotree toggle<cr>')
require('langmapper').setup{}
require('due_nvim').setup{
  use_clock_time = true,
  use_clock_today = true,
  use_seconds = true
}
