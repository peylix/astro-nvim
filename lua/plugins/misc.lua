local profile = require "profile"

---@type LazySpec
return {
  {
    "rmagatti/auto-session",
    enabled = profile.is_default,
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "~/Documents/", "/" },
      -- log_level = 'debug',
    },
  },

  {
    "glacambre/firenvim",
    enabled = false,
    build = ":call firenvim#install(0)",
  },

  {
    "eandrju/cellular-automaton.nvim",
    enabled = false,
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
    enabled = false,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      {
        "<C-esc>",
        mode = { "t" },
        [[<C-\><C-n>]],
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    enabled = false,
    opts = {},
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require("oil").setup {
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        },
      }
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>-o", require("oil").toggle_float, { desc = "Toggle Oil" })
    end,
  },

  {
    "jrop/tuis.nvim",
    config = function()
      -- Optional: set up keymaps
      vim.keymap.set("n", "<leader>tm", function() require("tuis").choose() end, { desc = "Choose Morph UI" })
    end,
  },

  {
    "RaafatTurki/hex.nvim",
    cmd = { "HexDump", "HexAssemble", "HexToggle" },
    config = function() require("hex").setup() end,
  },

  {
    "keaising/im-select.nvim",
    -- for auto switching input method to English when entering/leaving insert mode or switching focus.
    -- NOTE: The English input source should be US keyboard.
    enabled = profile.is_default and vim.fn.has "mac" == 1,
    event = { "InsertEnter", "FocusGained" },
    config = function()
      require("im_select").setup {
        default_im_select = "com.apple.keylayout.US",
        default_command = "macism",
        set_default_events = { "InsertLeave", "CmdlineLeave", "FocusGained" },
        set_previous_events = { "InsertEnter" },
        async_switch_im = true,
      }
    end,
  },
}
