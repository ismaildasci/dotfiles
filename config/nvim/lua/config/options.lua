-- Options
-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false -- LazyVim shows mode in statusline
opt.pumblend = 10 -- Popup menu transparency
opt.pumheight = 10 -- Max items in popup menu

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.shiftround = true

-- PHP/Laravel specific - 4 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php", "blade" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- JavaScript/TypeScript - 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "json", "yaml" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Editing
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Faster updates for CursorHold
opt.timeoutlen = 300 -- Faster which-key popup

-- Splits
opt.splitbelow = true
opt.splitright = true

-- File handling
opt.autowrite = true
opt.confirm = true -- Confirm to save changes before exiting
opt.swapfile = false

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"

-- Folding (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- Don't fold by default
opt.foldlevel = 99

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Session
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Fix markdown indentation
vim.g.markdown_recommended_style = 0
