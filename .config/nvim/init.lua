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
},

  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
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

-- require("telescope").load_extension("bookmarks")
-- require("bookmarks").setup({
--     storage_dir = "/home/ikillmylinux/.config/nvim/bookmarks",
--     mappings_enabled = true,
--     keymap = {
--         toggle = "<tab><tab>",
--         close = "q",
--         add = "\\z",
--         add_global = "\\g", -- Add global bookmarks(global keymap), global bookmarks will appear in all projects. Identified with the symbol '󰯾'
--         jump = "<CR>", -- Jump from bookmarks(buf keymap)
--         delete = "dd", -- Delete bookmarks(buf keymap)
--         order = "<space><space>", -- Order bookmarks by frequency or updated_time(buf keymap)
--         delete_on_virt = "\\dd", -- Delete bookmark at virt text line(global keymap)
--         show_desc = "\\sd", -- show bookmark desc(global keymap)
--         focus_tags = "<c-j>",      -- focus tags window
--         focus_bookmarks = "<c-k>", -- focus bookmarks window
--         toogle_focus = "<S-Tab>", -- toggle window focus (tags-window <-> bookmarks-window)
--     },
--     width = 0.8, -- Bookmarks window width:  (0, 1]
--     height = 0.7, -- Bookmarks window height: (0, 1]
--     preview_ratio = 0.45, -- Bookmarks preview window ratio (0, 1]
--     tags_ratio = 0.1, -- Bookmarks tags window ratio
--     fix_enable = false, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.
--
--     virt_text = "", -- Show virt text at the end of bookmarked lines, if it is empty, use the description of bookmarks instead.
--     sign_icon = "󰃃",                                           -- if it is not empty, show icon in signColumn.
--     virt_pattern = { "*.go", "*.lua", "*.sh", "*.php", "*.rs" }, -- Show virt text only on matched pattern
--     virt_ignore_pattern = {}, -- Ignore showing virt text on matched pattern, this works after virt_pattern
--     border_style = "single", -- border style: "single", "double", "rounded" 
--     hl = {
--         border = "TelescopeBorder", -- border highlight
--         cursorline = "guibg=Gray guifg=White", -- cursorline highlight
--     },
--     datetime_format = "%Y-%m-%d %H:%M:%S", -- os.date
--     -- •	%Y: Four-digit year
--     -- •	%m: Two-digit month (01 to 12)
--     -- •	%d: Two-digit day (01 to 31)
--     -- •	%H: Hour in 24-hour format (00 to 23)
--     -- •	%I: Hour in 12-hour format (01 to 12)
--     -- •	%M: Two-digit minute (00 to 59)
--     -- •	%S: Two-digit second (00 to 59)
--     -- •	%p: AM/PM indicator
-- })

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

vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })
