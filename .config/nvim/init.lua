require("pm")
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
-- vim.g.markdown_folding = 1
vim.g.markdown_fenced_languages = {'python', 'cpp', 'c', 'lua', 'bash', 'conf', 'sh' }
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = { eob = " " }
vim.opt.termguicolors = true
-- vim.opt.conceallevel = 3



require("lazy").setup({
  spec = {
        "nvim-telekasten/telekasten.nvim",
        "backdround/global-note.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate"
        },
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
        'koalhack/koalight.nvim',
        "kylechui/nvim-surround",
        "chrisgrieser/nvim-scissors",
        "L3MON4D3/LuaSnip",
        'hrsh7th/nvim-cmp',
        'saadparwaiz1/cmp_luasnip',
        {
            'MeanderingProgrammer/markdown.nvim',
            main = "render-markdown",
            name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        },
        "allen-mack/nvim-table-md",
        'akinsho/bufferline.nvim',
        {
            'Kicamon/markdown-table-mode.nvim',
            commit = '03abd2c',
        },
        'mzlogin/vim-markdown-toc',
        { dir = '~/example.nvim' },
        "folke/zen-mode.nvim",
        {
            "toppair/peek.nvim",
            event = { "VeryLazy" },
            build = "deno task --quiet build:fast",
            config = function()
                require("peek").setup()
                vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
                vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
            end,
        },
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
-- vim.keymap.set("n", "<leader>y", "<cmd>Telekasten yank_notelink<CR>")

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


require("bufferline").setup({
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

require('markdown-table-mode').setup({
    options = {
        insert = true,
        insert_leave = true,
    }
})

-- default config:
require('peek').setup({
  auto_load = true,         -- whether to automatically load preview when
                            -- entering another markdown buffer
  close_on_bdelete = true,  -- close preview window on buffer delete

  syntax = true,            -- enable syntax highlighting, affects performance

  theme = 'dark',           -- 'dark' or 'light'

  update_on_change = true,

  app = 'firefox',          -- 'webview', 'browser', string or a table of strings
                            -- explained below

  filetype = { 'markdown' },-- list of filetypes to recognize as markdown

  -- relevant if update_on_change is true
  throttle_at = 200000,     -- start throttling when file exceeds this
                            -- amount of bytes in size
  throttle_time = 'auto',   -- minimum amount of time in milliseconds
                            -- that has to pass before starting new render
})

-- require("markdown").setup({
-- })

require("zen-mode").setup({
  window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      -- you may turn on/off statusline in zen mode by setting 'laststatus' 
      -- statusline will be shown only if 'laststatus' == 3
      laststatus = 0, -- turn off the statusline in zen mode
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
    -- this will change the font size on alacritty when in zen mode
    -- requires  Alacritty Version 0.10.0 or higher
    -- uses `alacritty msg` subcommand to change font size
    alacritty = {
      enabled = false,
      font = "14", -- font size
    },
    -- this will change the font size on wezterm when in zen mode
    -- See alse also the Plugins/Wezterm section in this projects README
    wezterm = {
      enabled = false,
      -- can be either an absolute font size or the number of incremental steps
      font = "+4", -- (10% increase per step)
    },
    -- this will change the scale factor in Neovide when in zen mode
    -- See alse also the Plugins/Wezterm section in this projects README
    neovide =
    {
        enabled = false,
        -- Will multiply the current scale factor by this number
        scale = 1.2,
        -- disable the Neovide animations while in Zen mode
        disable_animations =
	{
                neovide_animation_length = 0,
                neovide_cursor_animate_command_line = false,
                neovide_scroll_animation_length = 0,
                neovide_position_animation_length = 0,
                neovide_cursor_animation_length = 0,
                neovide_cursor_vfx_mode = "",
	}
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash" },
  auto_install = true,
}


require('render-markdown').setup({
    code = {
        -- Turn on / off code block & inline code rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = false,
        -- Determines how code blocks & inline code are rendered:
        --  none: disables all rendering
        --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
        --  language: adds language icon to sign column if enabled and icon + name above code blocks
        --  full: normal + language
        style = 'full',
        -- Determines where language icon is rendered:
        --  right: Right side of code block
        --  left: Left side of code block
        position = 'left',
        -- An array of language names for which background highlighting will be disabled
        -- Likely because that language has background highlights itself
        disable_background = { 'diff' },
        -- Amount of padding to add to the left of code blocks
        left_pad = 0,
        -- Amount of padding to add to the right of code blocks when width is 'block'
        right_pad = 0,
        -- Width of the code block background:
        --  block: width of the code block
        --  full: full width of the window
        width = 'block',
        -- Determins how the top / bottom of code block are rendered:
        --  thick: use the same highlight as the code body
        --  thin: when lines are empty overlay the above & below icons
        border = 'thick',
        -- Used above code blocks for thin border
        above = '▄',
        -- Used below code blocks for thin border
        below = '▀',
        -- Highlight for code blocks
        highlight = 'RenderMarkdownCode',
        -- Highlight for inline code
        highlight_inline = 'RenderMarkdownCodeInline',
    },
    heading = {
        -- Turn on / off heading icon & background rendering
        enabled = false,
        -- Turn on / off any sign column related rendering
        sign = false,
        -- Determines how the icon fills the available space:
        --  inline: underlying '#'s are concealed resulting in a left aligned icon
        --  overlay: result is left padded with spaces to hide any additional '#'
        position = 'inline',
        -- Replaces '#+' of 'atx_h._marker'
        -- The number of '#' in the heading determines the 'level'
        -- The 'level' is used to index into the array using a cycle
        -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        icons = {},
        -- Added to the sign column if enabled
        -- The 'level' is used to index into the array using a cycle
        signs = { '󰫎 ' },
        -- Width of the heading background:
        --  block: width of the heading text
        --  full: full width of the window
        width = 'block',
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading icon and extends through the entire line
        backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
        },
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading and sign icons
        foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
        },
    },

})

vim.api.nvim_create_user_command('CopyLink', function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ':h:t')
    local name = vim.fn.fnamemodify(filepath, ':t:r')
    local link = "[[" .. dir .. "/" .. name .. "]]"
    vim.api.nvim_command("let @+ = '".. link .."'")
    print("yanked " .. link)
    link = nil
end, {})


vim.keymap.set({ "n", "v" }, "<leader>y", "<cmd>CopyLink<cr>", {})


require('example')
