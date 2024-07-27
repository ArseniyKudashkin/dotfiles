vim.g.loaded_matchparen = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.swapfile = false
vim.g.markdown_fenced_languages = {'python', 'cpp', 'c', 'lua', 'bash'}
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.wo.conceallevel = 2
vim.api.nvim_set_keymap('n', '<F5>', ':CheatsheetEdit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Space>', ':Telekasten toggle_todo<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telekasten find_notes<CR>")   -- by name
vim.keymap.set("n", "<leader>g", "<cmd>Telekasten search_notes<CR>") -- by content
vim.keymap.set("n", "<CR>",       "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
vim.keymap.set("n", "<F2>", "<cmd>Telekasten rename_note<CR>")
vim.keymap.set("n", "<leader>y", "<cmd>Telekasten yank_notelink<CR>")

vim.keymap.set("n", "<F1>", "<cmd>WhichKey<CR>")
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")


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
    "LintaoAmons/bookmarks.nvim",
    "stevearc/dressing.nvim",
    "nvim-tree/nvim-tree.lua",
    "folke/which-key.nvim",
    "jbyuki/nabla.nvim",
    "nvim-telekasten/telekasten.nvim",
    'koalhack/koalight.nvim',
    "startup-nvim/startup.nvim",
    "kylechui/nvim-surround",
    "chrisgrieser/nvim-scissors",
    "L3MON4D3/LuaSnip",
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
    },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})



local global_note = require("global-note")
global_note.setup({
    filename = "todo.md",
    directory = "~/openNotes/Ar/",
})
require('telekasten').setup({
  home = vim.fn.expand("~/openNotes"),
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

vim.keymap.set("n", "<leader>m", open_random_markdown_file)


vim.api.nvim_create_user_command('Ltx', function()
  require"nabla".enable_virt()
  print("psshh. LATEX preview")
end, {})
vim.cmd.colorscheme 'koalight'
require"startup".setup()
require("nvim-surround").setup()
require("scissors").setup({
    snippetDir = "/home/ikillmylinux/.config/nvim/snippets",
})

require("luasnip").setup {
	store_selection_keys = "<Tab>",
}
require("luasnip.loaders.from_vscode").lazy_load {
	paths = { "/home/ikillmylinux/.config/nvim/snippets" },
}
local cmp = require'cmp'
cmp.setup({
    sources = {
        { name = "luasnip" },
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        },
    snippet = {
        expand = function(args)
            local luasnip = prequire("luasnip")
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    },
})
