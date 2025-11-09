-- This plugin is for monitoring GitHub Actions status
return {
  'topaxi/pipeline.nvim',
  keys = {
    { '<leader>ge', '<cmd>Pipeline<cr>', desc = 'Open pipeline.nvim' },
  },
  -- optional, you can also install and use `yq` instead.
  build = 'make',
  ---@type pipeline.Config
  opts = {},
}
