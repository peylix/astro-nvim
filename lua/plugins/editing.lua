local profile = require "profile"

---@type LazySpec
return {
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

  {
    "mluders/comfy-line-numbers.nvim",
    opts = {

      labels = {
        "1",
        "2",
        "3",
        "8",
        "9",
        "11",
        "12",
        "13",
        "18",
        "19",
        "21",
        "22",
        "23",
        "28",
        "29",
        "31",
        "32",
        "33",
        "38",
        "39",
        "41",
        "42",
        "43",
        "48",
        "49",
        -- "51",
        -- "52",
        -- "53",
        -- "58",
        -- "59",
        "111",
        "112",
        "113",
        "118",
        "119",
        "121",
        "122",
        "123",
        "128",
        "129",
        "131",
        "132",
        "133",
        "138",
        "139",
        "141",
        "142",
        "143",
        "148",
        "149",
        -- "151",
        -- "152",
        -- "153",
        -- "158",
        -- "159",
        "211",
        "212",
        "213",
        "218",
        "219",
        "221",
        "222",
        "223",
        "228",
        "229",
        "231",
        "232",
        "233",
        "238",
        "239",
        "241",
        "242",
        "243",
        "248",
        "249",
        -- "251",
        -- "252",
        -- "253",
        -- "258",
        -- "259",
      },
      up_key = "k",
      down_key = "j",

      -- Line numbers will be completely hidden for the following file/buffer types
      hidden_file_types = { "undotree" },
      hidden_buffer_types = { "terminal", "nofile" },
    },
  },

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
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    dependencies = profile.is_reduced and {} or { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = profile.is_reduced and {} or { "copilot" },
        providers = profile.is_reduced and {} or {
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
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require("grug-far").setup {
        -- options, see Configuration section below
        -- there are no required options atm
        vim.keymap.set(
          { "n", "x" },
          "<leader>fR",
          function() require("grug-far").open { visualSelectionUsage = "operate-within-range" } end,
          { desc = "grug-far: Search within range" }
        ),
      }
    end,
  },

  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    keys = {
      { "gD", "<cmd>Glance definitions<cr>", desc = "Glance Definitions" },
      { "gR", "<cmd>Glance references<cr>", desc = "Glance References" },
      { "gY", "<cmd>Glance type_definitions<cr>", desc = "Glance Type Definitions" },
      { "gM", "<cmd>Glance implementations<cr>", desc = "Glance Implementations" },
    },
  },

  {
    "rmagatti/goto-preview",
    enabled = false,
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    opts = {
      default_mappings = true,
    },
  },
}
