vim.keymap.set({ 'v', 'i' }, 'fd', '<Esc>', { silent = true })

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- togglers
vim.keymap.set({ 'n' }, 'yon', function()
  vim.cmd("set invnumber")
  vim.cmd("set invrelativenumber")
end, { silent = true })

vim.keymap.set({ 'n' }, 'yoh', function()
  vim.cmd("set invhlsearch")
end, { silent = true })

local function toggle_bg()
  local bg = vim.o.background == "dark" and "light" or "dark"
  vim.o.background = bg
end

vim.keymap.set("n", "yob", toggle_bg)

local is_diagnostics_hidden = false

local function toggle_diagnostics()
  if is_diagnostics_hidden then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end

  is_diagnostics_hidden = not is_diagnostics_hidden
end

vim.keymap.set("n", "yod", toggle_diagnostics)

-- Easier moving between splits
for char in ("HJKL"):gmatch(".") do
  local char_combo_suffix = char .. '>'

  vim.keymap.set({ 'n' }, '<C-' .. char_combo_suffix, '<C-W><C-' .. char_combo_suffix)
end

-- ;; Very magic
-- (vmap :/ :/\v)
-- (nmap :/ :/\v)
-- (nmap "]q" #(vim.cmd :cnext))
-- (nmap "[q" #(vim.cmd :cprev))

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
