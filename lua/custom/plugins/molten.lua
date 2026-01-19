return {
  'benlubas/molten-nvim',
  version = '^1.0.0',
  dependencies = { '3rd/image.nvim' },
  build = ':UpdateRemotePlugins',
  init = function()
    vim.g.molten_auto_open_output = false
    vim.g.molten_image_provider = 'image.nvim'
    vim.g.molten_output_win_max_height = 20
    -- FIXME: not finding cells. Uncommet when fixed
    --vim.g.molten_virt_lines_off_by_1 = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_warp_output = true
  end,
  config = function()
    -- Keymaps
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', '<localleader>' .. keys, func, { silent = true, desc = desc })
    end
    map('mm', ':MoltenInit<CR>', 'Initialize Molten')
    map('me', ':MoltenEvaluateOperator<CR>', 'Evaluate operator')
    map('ml', ':MoltenEvaluateLine<CR>', 'Evaluate line')
    map('mr', ':MoltenReevaluateCell<CR>', 'Re-evaluate cell')
    map('mv', ':<C-u>MoltenEvaluateVisual<CR>gv', 'Evaluate visual selection', 'v')
    map('md', ':MoltenDelete<CR>', 'Delete Molten cell')
    map('mo', ':MoltenShowOutput<CR>', 'Show output')
    map('mo', ':MoltenShowOutput<CR>', 'Show output')
    map('mi', ':noautocmd MoltenEnterOutput<CR>', 'Enter or show output')
    map('mh', ':MoltenHideOutput<CR>', 'Hide output')
  end,
}
