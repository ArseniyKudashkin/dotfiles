vim.g.loaded_matchparen = 1
vim.opt.number = true vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.wo.conceallevel = 2
vim.api.nvim_set_keymap('n', '<F5>', ':CheatsheetEdit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>o', ':ObsidianQuickSwitch<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>s', ':ObsidianSearch<CR>', {})
vim.api.nvim_set_keymap('n', '<C-Space>', ':ObsidianToggleCheckbox<CR>', { noremap = true, silent = true })

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
    "numToStr/Comment.nvim",
    "doctorfree/cheatsheet.nvim",
    "crusj/bookmarks.nvim",
    "YannickFricke/codestats.nvim",
    "nvim-lua/plenary.nvim",
    "epwalsh/obsidian.nvim",
    "LintaoAmons/bookmarks.nvim",
    "stevearc/dressing.nvim",
    "nvim-tree/nvim-tree.lua",
    },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})

local global_note = require("global-note")
global_note.setup({
    filename = "todo.md",
    directory = "~/openNotes/Ar/",
})

vim.keymap.set("n", "<leader>t", global_note.toggle_note, {
  desc = "Toggle global note",
})

require("cheatsheet").setup({
    bundled_cheatsheets = false,
    bundled_plugin_cheatsheets = false,
    include_only_installed_plugins = false,
})

require('codestats-nvim').setup({
    token = "SFMyNTY.WlhabGNubGtZWGxwYTJsc2JHMTViR2x1ZFhnPSMjTWpNeE56Yz0.u-K565NaEapeZ7km1TvjUFlyOX7q9beFuIzrNlVqv8o",
    endpoint = "https://codestats.net",
    interval = 60,
})

require("markview").setup({
    list_items = {
        enable = false,
    },
    horizontal_rules =
    {
        parts = {
            {
                type = "repeating",
                text = "-",
                repeat_amount = function ()
                    return vim.o.columns;
                end,
            }
        },
    },
    code_blocks =
    {
        enable = true,
        style = "language",
        position = "overlay",

        hl = "markdownCodeBlock",

        min_width = 70,
        pad_char = " ",
        pad_amount = 2,

        language_names = nil,
        name_hl = nil,
        language_direction = "right",

        sign = true,
        sign_hl = nil
    },
})

require("obsidian").setup({
    disable_frontmatter = true,

    follow_url_func = function(url)
        vim.fn.jobstart({"xdg-open", url})
    end,

    workspaces = {
        {
            name = "openNotes",
            path = "~/openNotes",
        },
    },
    ui = {
        enable = true,
        checkboxes = {
              [" "] = { hl_group = "ObsidianTodo" },
              ["x"] = { hl_group = "ObsidianDone" },
        },
        external_link_icon = { char = "" },

    },
})

require("bookmarks").setup({})
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>NvimTreeToggle<cr>", {})
vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })

local markdown_dir = "/home/ikillmylinux/openNotes/Ar"
local function open_random_markdown_file()
  local markdown_files = {}

  for _, file in ipairs(vim.fn.readdir(markdown_dir)) do
    if vim.fn.fnamemodify(file, ":e") == "md" then
      table.insert(markdown_files, file)
    end
  end

  if #markdown_files == 0 then
    print("No Markdown files found in the directory.")
    return
  end

  local random_file = markdown_files[math.random(#markdown_files)]
  vim.cmd("edit " .. markdown_dir .. "/" .. random_file)
end

vim.keymap.set("n", "<leader>m", open_random_markdown_file, { silent = true })
