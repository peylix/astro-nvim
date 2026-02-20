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
    "EdenEast/nightfox.nvim",
    enabled = true,
    opts = {
      dim_inactive = true,
    },
  },

  {
    "vague-theme/vague.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function() require("vague").setup {} end,
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    enabled = false,
    -- config = function()
    --   vim.opt.background = "dark"
    -- end
  },

  {
    "yorumicolors/yorumi.nvim",
    name = "yorumi",
    priority = 1000,
  },
}
