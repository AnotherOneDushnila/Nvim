--- Toggleterm setup
require("toggleterm").setup({open_mapping = [[<c-\>]]})

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end,

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')



--- Cappuccin setup
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})



--- LSP setup
local lspconfig = require('lspconfig') 

lspconfig.golangci_lint_ls.setup{}
lspconfig.cmake.setup{}
lspconfig.clangd.setup{}
lspconfig.pylsp.setup{}


--- Mason
require("mason-lspconfig").setup{}



--- CMP setup
local cmp = require'cmp'

cmp.setup({
snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

    -- For `mini.snippets` users:
    -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
    -- insert({ body = args.body }) -- Insert at cursor
    -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
    -- require("cmp.config").set_onetime({ sources = {} })
    end,
},
window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
}, {
    { name = 'buffer' },
})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
    { name = 'git' },
}, {
    { name = 'buffer' },
})
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
    { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
    { name = 'path' }
}, {
    { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
capabilities = capabilities

}


require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil , -- use a custom function for sorting files and directories in the tree 
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	default_component_configs = {
	  container = {
	    enable_character_fade = true
	  },
	  indent = {
	    indent_size = 2,
	    padding = 1, -- extra padding on left hand side
	    -- indent guides
	    with_markers = true,
	    indent_marker = "│",
	    last_indent_marker = "└",
	    highlight = "NeoTreeIndentMarker",
	    -- expander config, needed for nesting files
	    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
	    expander_collapsed = "",
	    expander_expanded = "",
	    expander_highlight = "NeoTreeExpander",
	  },
	  icon = {
	    folder_closed = "",
	    folder_open = "",
	    folder_empty = "󰜌",
	    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
	    -- then these will never be used.
	    default = "*",
	    highlight = "NeoTreeFileIcon"
	  },
	  modified = {
	    symbol = "[+]",
	    highlight = "NeoTreeModified",
	  },
	  name = {
	    trailing_slash = false,
	    use_git_status_colors = true,
	    highlight = "NeoTreeFileName",
	  },
	  git_status = {
	    symbols = {
	      -- Change type
	      added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
	      modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
	      deleted   = "✖",-- this can only be used in the git_status source
	      renamed   = "󰁕",-- this can only be used in the git_status source
	      -- Status type
	      untracked = "",
	      ignored   = "",
	      unstaged  = "󰄱",
	      staged    = "",
	      conflict  = "",
	    }
	  },
	  -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
	  file_size = {
	    enabled = true,
	    required_width = 64, -- min width of window required to show this column
	  },
	  type = {
	    enabled = true,
	    required_width = 122, -- min width of window required to show this column
	  },
	  last_modified = {
	    enabled = true,
	    required_width = 88, -- min width of window required to show this column
	  },
	  created = {
	    enabled = true,
	    required_width = 110, -- min width of window required to show this column
	  },
	  symlink_target = {
	    enabled = false,
	  },
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-custom-commands-global`
	commands = {},
	window = {
	  position = "left",
	  width = 22,
	  mapping_options = {
	    noremap = true,
	    nowait = true,
	  },
	  mappings = {
	    ["<space>"] = { 
	        "toggle_node", 
	        nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
	    },
	    ["<2-LeftMouse>"] = "open",
	    ["<cr>"] = "open",
	    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
	    ["P"] = { "toggle_preview", config = { use_float = true } },
	    ["l"] = "focus_preview",
	    ["S"] = "open_split",
	    ["s"] = "open_vsplit",
	    -- ["S"] = "split_with_window_picker",
	    -- ["s"] = "vsplit_with_window_picker",
	    ["t"] = "open_tabnew",
	    -- ["<cr>"] = "open_drop",
	    -- ["t"] = "open_tab_drop",
	    ["w"] = "open_with_window_picker",
	    --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
	    ["C"] = "close_node",
	    -- ['C'] = 'close_all_subnodes',
	    ["z"] = "close_all_nodes",
	    --["Z"] = "expand_all_nodes",
	    ["a"] = { 
	      "add",
	      -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
	      -- some commands may take optional config options, see `:h neo-tree-mappings` for details
	      config = {
	        show_path = "none" -- "none", "relative", "absolute"
	      }
	    },
	    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
	    ["d"] = "delete",
	    ["r"] = "rename",
	    ["y"] = "copy_to_clipboard",
	    ["x"] = "cut_to_clipboard",
	    ["p"] = "paste_from_clipboard",
	    ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
	    -- ["c"] = {
	    --  "copy",
	    --  config = {
	    --    show_path = "none" -- "none", "relative", "absolute"
	    --  }
	    --}
	    ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
	    ["q"] = "close_window",
	    ["R"] = "refresh",
	    ["?"] = "show_help",
	    ["<"] = "prev_source",
	    [">"] = "next_source",
	    ["i"] = "show_file_details",
	  }
	},
	nesting_rules = {},
	filesystem = {
	  filtered_items = {
	    visible = false, -- when true, they will just be displayed differently than normal items
	    hide_dotfiles = false,
	    hide_gitignored = true,
	    hide_hidden = true, -- only works on Windows for hidden files/directories
	    hide_by_name = {
	      --"node_modules"
	    },
	    hide_by_pattern = { -- uses glob style patterns
	      --"*.meta",
	      --"*/src/*/tsconfig.json",
	    },
	    always_show = { -- remains visible even if other settings would normally hide it
	      ".gitignored",
	    },
	    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
	      --".DS_Store",
	      --"thumbs.db"
	    },
	    never_show_by_pattern = { -- uses glob style patterns
	      --".null-ls_*",
	    },
	  },
	  follow_current_file = {
	    enabled = false, -- This will find and focus the file in the active buffer every time
	    --               -- the current file is changed while the tree is open.
	    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	  },
	  group_empty_dirs = false, -- when true, empty folders will be grouped together
	  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
	                                          -- in whatever position is specified in window.position
	                        -- "open_current",  -- netrw disabled, opening a directory opens within the
	                                          -- window like netrw would, regardless of window.position
	                        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
	  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
	                                  -- instead of relying on nvim autocmd events.
	  window = {
	    mappings = {
	      ["<bs>"] = "navigate_up",
	      ["."] = "set_root",
	      ["H"] = "toggle_hidden",
	      ["/"] = "fuzzy_finder",
	      ["D"] = "fuzzy_finder_directory",
	      ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
	      -- ["D"] = "fuzzy_sorter_directory",
	      ["f"] = "filter_on_submit",
	      ["<c-x>"] = "clear_filter",
	      ["[g"] = "prev_git_modified",
	      ["]g"] = "next_git_modified",
	      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
	      ["oc"] = { "order_by_created", nowait = false },
	      ["od"] = { "order_by_diagnostics", nowait = false },
	      ["og"] = { "order_by_git_status", nowait = false },
	      ["om"] = { "order_by_modified", nowait = false },
	      ["on"] = { "order_by_name", nowait = false },
	      ["os"] = { "order_by_size", nowait = false },
	      ["ot"] = { "order_by_type", nowait = false },
	    },
	    fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
	      ["<down>"] = "move_cursor_down",
	      ["<C-n>"] = "move_cursor_down",
	      ["<up>"] = "move_cursor_up",
	      ["<C-p>"] = "move_cursor_up",
	    },
	  },
	
	  commands = {} -- Add a custom command or override a global one using the same function name
	},
	buffers = {
	  follow_current_file = {
	    enabled = true, -- This will find and focus the file in the active buffer every time
	    --              -- the current file is changed while the tree is open.
	    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
	  },
	  group_empty_dirs = true, -- when true, empty folders will be grouped together
	  show_unloaded = true,
	  window = {
	    mappings = {
	      ["bd"] = "buffer_delete",
	      ["<bs>"] = "navigate_up",
	      ["."] = "set_root",
	      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
	      ["oc"] = { "order_by_created", nowait = false },
	      ["od"] = { "order_by_diagnostics", nowait = false },
	      ["om"] = { "order_by_modified", nowait = false },
	      ["on"] = { "order_by_name", nowait = false },
	      ["os"] = { "order_by_size", nowait = false },
	      ["ot"] = { "order_by_type", nowait = false },
	    }
	  },
	},
	git_status = {
	  window = {
	    position = "float",
	    mappings = {
	      ["A"]  = "git_add_all",
	      ["gu"] = "git_unstage_file",
	      ["ga"] = "git_add_file",
	      ["gr"] = "git_revert_file",
	      ["gc"] = "git_commit",
	      ["gp"] = "git_push",
	      ["gg"] = "git_commit_and_push",
	      ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
	      ["oc"] = { "order_by_created", nowait = false },
	      ["od"] = { "order_by_diagnostics", nowait = false },
	      ["om"] = { "order_by_modified", nowait = false },
	      ["on"] = { "order_by_name", nowait = false },
	      ["os"] = { "order_by_size", nowait = false },
	      ["ot"] = { "order_by_type", nowait = false },
	    }
	  }
	}
})

--- Null ls setup
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ 
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end
					 })
                    -- vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})


-- Whichkey setup

local wk = require("which-key")

wk.register({
    f = {
        name = "Find",
        f = {"Find File"},
        b = {"Find Buffer"},
        h = {"Find Help"},
        w = {"Find Text"}
    },
    e = {"File Manager"},
    o = {"Git status"},
    x = {"Close Buffer"},
    w = {"Save"},
    t = {name = "Terminal", f = {"Float terminal"}, h = {"Horizontal terminal"}},
    h = {"No highlight"},
    g = {name = "Git", b = "Branches", c = "Commits", s = "Status"},
    c = {name = "Comment", l = "Comment Line"},
    l = {
        name = "LSP",
        d = "Diagnostic",
        D = "Hover diagnostic",
        f = "Format",
        r = "Rename",
        a = "Action",
        s = "Symbol"
    }
}, {prefix = "<leader>"})


-- Visimatch setup

require("visimatch").setup(
    opts = {
        -- The highlight group to apply to matched text
        hl_group = "Search",
        -- The minimum number of selected characters required to trigger highlighting
        chars_lower_limit = 30,
        -- The maximum number of selected lines to trigger highlighting for
        lines_upper_limit = 30,
        -- By default, visimatch will highlight text even if it doesn't have exactly
        -- the same spacing as the selected region. You can set this to `true` if
        -- you're not a fan of this behaviour :)
        strict_spacing = false,
        -- Visible buffers which should be highlighted. Valid options:
        -- * `"filetype"` (the default): highlight buffers with the same filetype
        -- * `"current"`: highlight matches in the current buffer only
        -- * `"all"`: highlight matches in all visible buffers
        -- * A function. This will be passed a buffer number and should return
        --   `true`/`false` to indicate whether the buffer should be highlighted.
        buffers = "filetype"
        -- Case-(in)nsitivity for matches. Valid options:
        -- * `true`: matches will never be case-sensitive
        -- * `false`/`{}`: matches will always be case-sensitive
        -- * a table of filetypes to use use case-insensitive matching for.
        case_insensitive = { "markdown", "text", "help" },
    }
)

require('gitsigns').setup()