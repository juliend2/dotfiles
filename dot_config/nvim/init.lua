-- Colemak remaps for navigation
vim.keymap.set('', 'n', 'j', { noremap = true })
vim.keymap.set('', 'e', 'k', { noremap = true })
vim.keymap.set('', 'i', 'l', { noremap = true })

-- End of word navigation
vim.keymap.set('', 'j', 'e', { noremap = true })

-- Next in search mode
vim.keymap.set('', 'k', 'n', { noremap = true })

-- 'l' becomes insert mode
vim.keymap.set('', 'l', 'i', { noremap = true })

-- Split navigation
vim.keymap.set('', '<C-w>n', '<C-w>j', { noremap = true })
vim.keymap.set('', '<C-w>e', '<C-w>k', { noremap = true })
vim.keymap.set('', '<C-w>i', '<C-w>l', { noremap = true })

-- Move window right
vim.keymap.set('', '<C-w>I', '<C-w>L', { noremap = true })

-- Move window left
vim.keymap.set('', '<C-w>J', '<C-w>H', { noremap = true })

