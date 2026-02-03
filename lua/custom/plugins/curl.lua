return {
  'oysandvik94/curl.nvim',
  cmd = { 'CurlOpen', 'CurlCollection' },
  keys = {
    { '<leader>cc', '<cmd>CurlOpen<cr>', desc = 'Open curl (scoped)' },
    { '<leader>cg', '<cmd>CurlOpen global<cr>', desc = 'Open curl (global)' },
    { '<leader>cp', '<cmd>CurlCollection scoped<cr>', desc = 'Pick scoped collection' },
    { '<leader>cP', '<cmd>CurlCollection global<cr>', desc = 'Pick global collection' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    default_flags = { '-i' },
    open_with = 'split',
  },
}
