return {
  'sindrets/diffview.nvim',
  config = function()
    local actions = require 'diffview.actions'
    require('diffview').setup {
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
      keymaps = {
        diff3 = {
          { { 'n', 'x' }, '<leader>go', actions.conflict_choose 'ours', { desc = 'Choose OURS version' } },
          { { 'n', 'x' }, '<leader>gt', actions.conflict_choose 'theirs', { desc = 'Choose THEIRS version' } },
          { { 'n', 'x' }, '<leader>gb', actions.conflict_choose 'base', { desc = 'Choose BASE version' } },
          { { 'n', 'x' }, '<leader>ga', actions.conflict_choose 'all', { desc = 'Choose ALL versions' } },
          { 'n', '<leader>gx', actions.conflict_choose 'none', { desc = 'Delete conflict region' } },
        },
        diff4 = {
          { { 'n', 'x' }, '<leader>go', actions.conflict_choose 'ours', { desc = 'Choose OURS version' } },
          { { 'n', 'x' }, '<leader>gt', actions.conflict_choose 'theirs', { desc = 'Choose THEIRS version' } },
          { { 'n', 'x' }, '<leader>gb', actions.conflict_choose 'base', { desc = 'Choose BASE version' } },
          { { 'n', 'x' }, '<leader>ga', actions.conflict_choose 'all', { desc = 'Choose ALL versions' } },
          { 'n', '<leader>gx', actions.conflict_choose 'none', { desc = 'Delete conflict region' } },
        },
      },
    }
  end,
}
