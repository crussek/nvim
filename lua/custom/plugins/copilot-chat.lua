-- Copilot Chat configuration for Neovim
return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  opts = {
    debug = true,
  },
  keys = {
    { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
  },
}
