---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
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
    "vague-theme/vague.nvim",
    enabled = true,
    lazy = false,
    -- priority = 1000,
    config = function()
      require("vague").setup {}
      -- Don't set colorscheme here, let AstroUI handle it
    end,
  },

  {
    "dgox16/oldworld.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
  },
}
