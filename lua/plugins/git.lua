return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "folke/snacks.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
    },
    opts = {
      disable_line_numbers = false,
      disable_relative_line_numbers = false,
    }
  },
  {
    "topaxi/pipeline.nvim",
    keys = {
      { "<leader>ge", "<cmd>Pipeline<cr>", desc = "Open pipeline.nvim" },
    },
    -- optional, you can also install and use `yq` instead.
    build = "make",
    ---@type pipeline.Config
    opts = {},
  },

  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function() require("blame").setup {} end,
    keys = {
      {
        "<leader>ga",
        mode = { "n", "v" },
        "<cmd>BlameToggle<cr>",
        desc = "Toggle the blame with provided view",
      },
    },
  },

  {
    "pwntester/octo.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup {
        picker = "snacks",
      }
    end,
  },
}
