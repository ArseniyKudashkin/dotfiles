vim.g.loaded_matchparen = 1
vim.opt.number = true
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.swapfile = false
vim.g.markdown_fenced_languages = {'python', 'cpp', 'c', 'lua', 'bash' }
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
vim.opt.conceallevel = 2




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
    vim.fn.getchar() os.exit(1) end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
        "nvim-telekasten/telekasten.nvim",
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
        "jbyuki/nabla.nvim", 'koalhack/koalight.nvim',
        "kylechui/nvim-surround",
        "chrisgrieser/nvim-scissors",
        "L3MON4D3/LuaSnip",
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
        "OXY2DEV/markview.nvim",
        "allen-mack/nvim-table-md",
        'akinsho/bufferline.nvim',
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
    auto_set_filetype = false,
})

vim.keymap.set("n", "<leader>q", global_note.toggle_note, {
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
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

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

vim.api.nvim_create_user_command('Ltx', function()
  require"nabla".enable_virt()
  print("psshh. LATEX preview")
end, {})

require("nvim-surround").setup()

require"scissors".setup{
    snippetDir = "/home/ikillmylinux/.config/nvim/snippets",
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

require("markview").setup({
    list_items = {
        enable = true,
        shift_width = 2,
        marker_minus = {
            add_padding = true,
            text = "•",
        }

    },
    tables = { enable = false },
    horizontal_rules = {
        parts = {
            {
                type = "repeating",
                text = "─",
                repeat_amount = function ()
                    return vim.o.columns;
                end,
            }
        }
    },
})



vim.keymap.set("n", "<leader>m", open_random_markdown_file)


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

vim.keymap.set("i", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")

vim.api.nvim_set_keymap("n", "<Leader>tf", ':lua require("tablemd").format()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tc", ':lua require("tablemd").insertColumn(false)<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>td", ':lua require("tablemd").deleteColumn()<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tr", ':lua require("tablemd").insertRow(false)<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tR", ':lua require("tablemd").insertRow(true)<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tj", ':lua require("tablemd").alignColumn("left")<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tk", ':lua require("tablemd").alignColumn("center")<cr>', { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tl", ':lua require("tablemd").alignColumn("right")<cr>', { noremap = true })


vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>NvimTreeToggle<cr>", {})
vim.keymap.set({ "n", "v" }, "mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
vim.keymap.set({ "n", "v" }, "mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
vim.keymap.set({ "n", "v" }, "ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
vim.keymap.set({ "n", "v" }, "mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })

vim.cmd.colorscheme 'koalight'

vim.api.nvim_create_user_command('CopyLink', function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ':h:t')
    local name = vim.fn.fnamemodify(filepath, ':t')
    local link = "[[" .. dir .. "/" .. name .. "]]"
    vim.api.nvim_command("let @+ = '".. link .."'")
    print("yanked " .. link)
    link = nil
end, {})


vim.keymap.set({ "n", "v" }, "<leader>cr", "<cmd>CopyLink<cr>", {})
require("bufferline").setup({
    -- options = {
    --     mode = "tabs",
    -- }
})

vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "[b", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "b]", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "bd", "<cmd>bdelete<CR>")

vim.cmd("hi link markdownError Normal")


