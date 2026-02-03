-- Copilot Chat configuration for Neovim
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  opts = {
    debug = true,
  },
  keys = {
    { '<leader>oo', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
    { '<leader>oe', '<cmd>CopilotChatExplain<cr>', desc = 'Explain code' },
    { '<leader>of', '<cmd>CopilotChatFix<cr>', desc = 'Fix code' },
  },
}
