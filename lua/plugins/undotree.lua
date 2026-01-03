return {
  "jiaoshijie/undotree",
  ---@module 'undotree.collector'
  ---@type UndoTreeCollector.Opts
  opts = {
    -- float_diff = false,
    -- layout = "left_bottom",
    position = "bottom",
  },
  keys = { -- load the plugin only when using it's keybinding:
    { "<leader>xu", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undo Tree" },
  },
}
