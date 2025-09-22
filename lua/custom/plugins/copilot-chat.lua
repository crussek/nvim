-- Copilot Chat configuration for Neovim
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    config = function()
      require('CopilotChat').setup {
        debug = false, -- Enable debugging

        -- Chat settings
        question_header = '## User ',
        answer_header = '## Copilot ',
        error_header = '## Error ',
        separator = ' ',

        -- Window settings
        window = {
          layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
          width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
          -- Options below only apply to floating windows
          relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
          row = nil, -- row position of the window, default is centered
          col = nil, -- column position of the window, default is centered
          title = 'Copilot Chat', -- title of chat window
          footer = nil, -- footer of chat window
          zindex = 1, -- determines if window is on top or below other floating windows
        },

        -- Chat settings
        show_help = true, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
        show_folds = true, -- Shows folds for sections in chat
        highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

        -- Default contexts
        context = 'buffers', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
        history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history
        callback = nil, -- Callback to use when ask response is received

        -- Default selection
        selection = function(source)
          return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
        end,

        -- default prompts
        prompts = {
          Explain = {
            prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
          },
          Review = {
            prompt = '/COPILOT_REVIEW Review the selected code.',
            callback = function(response, source)
              -- see config.lua for implementation
            end,
          },
          Fix = {
            prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
          },
          Optimize = {
            prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.',
          },
          Docs = {
            prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
          },
          Tests = {
            prompt = '/COPILOT_GENERATE Please generate tests for my code.',
          },
          FixDiagnostic = {
            prompt = 'Please assist with the following diagnostic issue in file:',
            selection = require('CopilotChat.select').diagnostics,
          },
          Commit = {
            prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
            selection = require('CopilotChat.select').gitdiff,
          },
          CommitStaged = {
            prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
            selection = function(source)
              return require('CopilotChat.select').gitdiff(source, true)
            end,
          },
        },
      }

      -- Key mappings
      local chat = require 'CopilotChat'
      local select = require 'CopilotChat.select'

      -- Chat commands
      vim.keymap.set('n', '<leader>cc', ':CopilotChat ', { desc = 'CopilotChat - Open chat' })
      vim.keymap.set('n', '<leader>ccq', function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          chat.ask(input, { selection = select.buffer })
        end
      end, { desc = 'CopilotChat - Quick chat' })

      -- Show help
      vim.keymap.set('n', '<leader>cch', function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.help_actions())
      end, { desc = 'CopilotChat - Help actions' })

      -- Show prompts
      vim.keymap.set('n', '<leader>ccp', function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
      end, { desc = 'CopilotChat - Prompt actions' })

      -- Visual mode mappings
      vim.keymap.set('v', '<leader>cc', ':CopilotChatVisual ', { desc = 'CopilotChat - Open in vertical split' })
      vim.keymap.set('v', '<leader>cx', ':CopilotChatInPlace<cr>', { desc = 'CopilotChat - Run in-place code' })

      -- Quick actions
      vim.keymap.set('n', '<leader>cce', '<cmd>CopilotChatExplain<cr>', { desc = 'CopilotChat - Explain code' })
      vim.keymap.set('n', '<leader>cct', '<cmd>CopilotChatTests<cr>', { desc = 'CopilotChat - Generate tests' })
      vim.keymap.set('n', '<leader>ccr', '<cmd>CopilotChatReview<cr>', { desc = 'CopilotChat - Review code' })
      vim.keymap.set('n', '<leader>ccR', '<cmd>CopilotChatRefactor<cr>', { desc = 'CopilotChat - Refactor code' })
      vim.keymap.set('n', '<leader>ccn', '<cmd>CopilotChatBetterNamings<cr>', { desc = 'CopilotChat - Better Naming' })

      -- Custom prompts
      vim.keymap.set('v', '<leader>ccv', function()
        chat.ask('Please explain how this code works.', { selection = select.visual })
      end, { desc = 'CopilotChat - Explain selection' })

      vim.keymap.set('n', '<leader>ccf', function()
        chat.ask('Fix this code', { selection = select.buffer })
      end, { desc = 'CopilotChat - Fix code' })

      -- Integration with telescope (optional)
      vim.keymap.set('n', '<leader>cca', function()
        local actions = require 'CopilotChat.actions'
        require('CopilotChat.integrations.telescope').pick(actions.prompt_actions {
          selection = select.visual,
        })
      end, { desc = 'CopilotChat - Prompt actions' })

      -- Debug info
      vim.keymap.set('n', '<leader>ccd', function()
        local copilot_chat = require 'CopilotChat'
        local info = copilot_chat.info()
        print(vim.inspect(info))
      end, { desc = 'CopilotChat - Debug Info' })

      -- Clear chat history
      vim.keymap.set('n', '<leader>ccl', function()
        local copilot_chat = require 'CopilotChat'
        copilot_chat.reset()
      end, { desc = 'CopilotChat - Clear chat history' })
    end,

    -- Commands
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatStop',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatDebugInfo',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommit',
      'CopilotChatCommitStaged',
    },

    -- Load on these events
    event = 'VeryLazy',
  },

  -- Optional: Integration with which-key for better key descriptions
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>cc', group = 'Copilot Chat' },
      },
    },
  },
}
