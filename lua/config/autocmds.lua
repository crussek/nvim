-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Breakpoints for Python
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    local function keymap_set(key, command, desc)
      vim.keymap.set('n', '<leader>' .. key, 'O' .. command .. '; pass  # XXX: BREAKPOINT<C-c>', { buffer = true, desc = desc .. ' breakpoint' })
    end

    keymap_set(',', 'import ipdb; ipdb.set_trace()', 'IPDB')
    keymap_set('<', 'from celery.contrib import rdb; rdb.set_trace()', 'RDB')
  end,
})
