vim.g.loaded_matchparen = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.api.nvim_set_keymap('n', '<F5>', ':CheatsheetEdit<CR>', { noremap = true, silent = true })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    "backdround/global-note.nvim",
    "OXY2DEV/markview.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "jghauser/mkdir.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "numToStr/Comment.nvim",
    "doctorfree/cheatsheet.nvim",
  },

  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

local global_note = require("global-note")
global_note.setup({
    filename = "todo.md",
    directory = "~/openNotes/Ar/",
})

vim.keymap.set("n", "<leader>n", global_note.toggle_note, {
  desc = "Toggle global note",
})

require("cheatsheet").setup({
    bundled_cheatsheets = false,
    bundled_plugin_cheatsheets = false,
    include_only_installed_plugins = false,
})

