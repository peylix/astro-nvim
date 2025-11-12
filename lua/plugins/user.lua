-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function() require("lsp_signature").setup() end,
  -- },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        layout = {
          preset = "ivy",
          layout = {
            backdrop = 60,
          },
        },
      },

      gh = {},

      scratch = {},
      dashboard = {
        preset = {
          header = table.concat({
            -- " █████  ███████ ████████ ██████   ██████ ",
            -- "██   ██ ██         ██    ██   ██ ██    ██",
            -- "███████ ███████    ██    ██████  ██    ██",
            -- "██   ██      ██    ██    ██   ██ ██    ██",
            -- "██   ██ ███████    ██    ██   ██  ██████ ",
            -- "",
            -- "███    ██ ██    ██ ██ ███    ███",
            -- "████   ██ ██    ██ ██ ████  ████",
            -- "██ ██  ██ ██    ██ ██ ██ ████ ██",
            -- "██  ██ ██  ██  ██  ██ ██  ██  ██",
            -- "██   ████   ████   ██ ██      ██",
            --
            --
            " ██████╗ ███████╗██╗   ██╗██╗     ██╗██╗  ██╗",
            " ██╔══██╗██╔════╝╚██╗ ██╔╝██║     ██║╚██╗██╔╝",
            " ██████╔╝█████╗   ╚████╔╝ ██║     ██║ ╚███╔╝ ",
            " ██╔═══╝ ██╔══╝    ╚██╔╝  ██║     ██║ ██╔██╗ ",
            " ██║     ███████╗   ██║   ███████╗██║██╔╝ ██╗",
            " ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝",
            "                                             ",
            " ███╗   ██╗██╗   ██╗██╗███╗   ███╗           ",
            " ████╗  ██║██║   ██║██║████╗ ████║           ",
            " ██╔██╗ ██║██║   ██║██║██╔████╔██║           ",
            " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║           ",
            " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║           ",
            " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝           ",
          }, "\n"),
        },
        -- sections = {
        --   { section = "header" },
        --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        --   { section = "startup" },
        -- },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 2 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      styles = {
        blame_line = {
          width = 0.6,
          height = 0.6,
          border = "rounded",
          title = " Git Blame ",
          title_pos = "center",
          ft = "git",
        },
      },
    },
    keys = {
      { "<leader>bt", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>bS", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue { state = "all" } end, desc = "GitHub Issues (all)" },
      { "<leader>gq", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gQ", function() Snacks.picker.gh_pr { state = "all" } end, desc = "GitHub Pull Requests (all)" },
    },
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
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
  },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-c",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>-w",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
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

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   -- enabled = false,
  --   opts = {
  --     config = {
  --       sources = { "filesystem", "diagnostics" },
  --     }
  --   },
  -- },

  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },

      -- keymap = {
      --   ["<Tab>"] = {
      --     "snippet_forward",
      --     function() -- sidekick next edit suggestion
      --       return require("sidekick").nes_jump_or_apply()
      --     end,
      --     function() -- if you are using Neovim's native inline completions
      --       return vim.lsp.inline_completion.get()
      --     end,
      --     "fallback",
      --   },
      -- },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          auto_display = true,
        },
      },
    },
  },
}
