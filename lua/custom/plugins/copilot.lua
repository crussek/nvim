-- GitHub Copilot configuration for Neovim
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<C-J>',
          accept_word = false,
          accept_line = false,
          next = '<C-N>',
          prev = '<C-P>',
          dismiss = '<C-H>',
        },
      },
      -- filetypes = {
      --   yaml = false,
      --   markdown = false,
      --   help = false,
      --   gitcommit = false,
      --   gitrebase = false,
      --   hgcommit = false,
      --   svn = false,
      --   cvs = false,
      --   ['.'] = false,
      -- },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
      vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
        fg = '#E5F013',
        italic = true,
      }),
    }
  end,
}
