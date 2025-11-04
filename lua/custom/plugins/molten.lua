return {
  'benlubas/molten-nvim',
  version = '^1.0.0',
  build = ':UpdateRemotePlugins',
  init = function()
    vim.g.molten_image_provider = 'none' -- disable inline images until new terminal
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
  end,
  config = function()
    -- Keymaps
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', '<localleader>' .. keys, func, { silent = true, desc = desc })
    end
    map('mi', ':MoltenInit<CR>', 'Initialize Molten')
    map('me', ':MoltenEvaluateOperator<CR>', 'Evaluate operator')
    map('ml', ':MoltenEvaluateLine<CR>', 'Evaluate line')
    map('mr', ':MoltenReevaluateCell<CR>', 'Re-evaluate cell')
    map('mv', ':<C-u>MoltenEvaluateVisual<CR>gv', 'Evaluate visual selection', 'v')
    map('md', ':MoltenDelete<CR>', 'Delete Molten cell')
    map('mo', ':MoltenShowOutput<CR>', 'Show output')
    map('mh', ':MoltenHideOutput<CR>', 'Hide output')
  end,
}
