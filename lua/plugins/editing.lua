return {
  {
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
  },

  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    -- keymaps are managed by lang_motion
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
