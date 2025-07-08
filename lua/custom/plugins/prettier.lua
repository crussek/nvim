-- ~/.config/nvim/lua/custom/plugins/prettier.lua
return {
  'MunifTanjim/prettier.nvim',
  dependencies = { 'jose-elias-alvarez/null-ls.nvim' },
  config = function()
    require('prettier').setup {
      bin = 'prettier', -- or 'prettierd'
      filetypes = {
        'javascript',
        'typescript',
        'css',
        'json',
        'markdown',
      },
    }
  end,
}
