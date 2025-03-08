local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Moving
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
-- keymap("i", "j", "gj", opts)
-- keymap("i", "k", "gk", opts)

keymap("n", "<Down>", "gj", opts)
keymap("n", "<Up>", "gk", opts)
-- keymap("i", "<Down>", "gj", opts)
-- keymap("i", "<Up>", "gk", opts)

-- LSP 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
--vim.keymap.set('n', 'gr', bultin.lsp_references, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

-- Telescope
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})


-- Terminal
vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])
vim.cmd([[:tnoremap <A-h> <C-\><C-N><C-w>h]])
vim.cmd([[:tnoremap <A-j> <C-\><C-N><C-w>j]])
vim.cmd([[:tnoremap <A-k> <C-\><C-N><C-w>k]])
vim.cmd([[:tnoremap <A-l> <C-\><C-N><C-w>l]])

vim.cmd([[:nnoremap <A-h> <C-w>h]])
vim.cmd([[:nnoremap <A-j> <C-w>j]])
vim.cmd([[:nnoremap <A-k> <C-w>k]])
vim.cmd([[:nnoremap <A-l> <C-w>l]])

vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])
vim.cmd([[:tnoremap <A-Left> <C-\><C-N><C-w>h]])
vim.cmd([[:tnoremap <A-Down> <C-\><C-N><C-w>j]])
vim.cmd([[:tnoremap <A-Up> <C-\><C-N><C-w>k]])
vim.cmd([[:tnoremap <A-Right> <C-\><C-N><C-w>l]])

vim.cmd([[:nnoremap <A-Left> <C-w>h]])
vim.cmd([[:nnoremap <A-Down> <C-w>j]])
vim.cmd([[:nnoremap <A-Up> <C-w>k]])
vim.cmd([[:nnoremap <A-Right> <C-w>l]])


-- Neotree
vim.cmd([[map <silent> <C-n> :Neotree<CR>]])

-- Disable highligth until next search
vim.keymap.set('n', 'z', ":noh<CR>", opts)

-- Null-ls formatting
vim.cmd('map <silent> <Leader>a :ClangFormat<CR>')

-- Open terminal in vertical split right and change to insert mode
keymap("n", "<leader>t", "<C-w>v :term<CR>i", opts)