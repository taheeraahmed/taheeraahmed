-- Basic sane defaults
vim.g.mapleader = " "          -- Space as leader key
vim.opt.number = true          -- Line numbers
vim.opt.relativenumber = true  -- Relative line numbers (great for jumping)
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true   -- True color support
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.autoread = true        -- Auto-reload files changed on disk (if buffer has no unsaved changes)

-- Actively check for external file changes (autoread alone only checks passively).
-- This polls whenever you move the cursor or switch focus, so edits made outside
-- Neovim (e.g. by another tool/process) show up automatically.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk, buffer reloaded", vim.log.levels.WARN)
  end,
})

-- Bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Basic keymaps (VSCode-ish feel)
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Search in files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close current buffer/tab" })

-- Comment toggle like VSCode's Ctrl+/
-- (terminals send Ctrl+/ as Ctrl+_ , so we map that too for reliability over SSH)
map({ "n" }, "<C-_>", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
map({ "n" }, "<C-/>", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle comment" })
map("v", "<C-_>", "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- Breadcrumbs in the winbar (shows function/class you're in, like VSCode)
function _G.statusline_navic()
  local ok, navic = pcall(require, "nvim-navic")
  if not ok or not navic.is_available() then
    return ""
  end
  return navic.get_location()
end
vim.o.winbar = "%{v:lua.statusline_navic()}"


