return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = true,
    opts = {
      dim_inactive = { enabled = true, percentage = 0.25 },
      color_overrides = {
        mocha = {
          -- lavender = "#c598b6",
          lavender = "#9091e8",
        },
      },
    },
  },

  {
    "sho-87/kanagawa-paper.nvim",
    enabled = false,
    opts = {
      dim_inactive = { enabled = true, percentage = 0.25 },
    },
  },

  {
    "EdenEast/nightfox.nvim",
    enabled = false,
    opts = {
      dim_inactive = true,
    },
  },

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup {
        -- Your config here
      }
    end,
  },
  {
    "vague-theme/vague.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup {
        -- optional configuration here
      }
      -- Don't set colorscheme here, let AstroUI handle it
    end,
  },
}
