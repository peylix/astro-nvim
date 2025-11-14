return {
  "noearc/jieba.nvim",
  dependencies = { "noearc/jieba-lua" },
  opts = {
    use_default_mappings = false,
  },
  config = function(_, opts)
    require("jieba_nvim").setup(opts)

    -- Setup keymaps
    require("lang_motion").setup_keymaps()

  end,
}
