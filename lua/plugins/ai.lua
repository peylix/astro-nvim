local profile = require "profile"
if profile.is_reduced then return {} end

---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<M-l>", -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    "folke/sidekick.nvim",
    enabled = true,
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },

      {
        "<leader>at",
        function() require("sidekick.cli").send { msg = "{this}" } end,
        mode = { "x", "n" },
        desc = "Send This",
      },

      {
        "<leader>af",
        function() require("sidekick.cli").send { msg = "{file}" } end,
        desc = "Send File",
      },

      {
        "<leader>av",
        function() require("sidekick.cli").send { msg = "{selection}" } end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },

      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },

      {
        "<leader>ao",
        function() require("sidekick.cli").toggle { name = "opencode", focus = true } end,
        desc = "Sidekick Toggle OpenCode",
      },
    },
  },

  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require "99"

      -- For logging that is to a file if you wish to trace through requests
      -- for reporting bugs, i would not rely on this, but instead the provided
      -- logging mechanisms within 99.  This is for more debugging purposes
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup {
        provider = _99.Providers.ClaudeCodeProvider,
        -- provider = _99.Providers.OpenCodeProvider,
        model = "claude-sonnet-4-6",
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },
        -- When setting this to something that is not inside the CWD tools
        -- such as claude code or opencode will have permission issues
        -- and generation will fail refer to tool documentation to resolve
        -- https://opencode.ai/docs/permissions/#external-directories
        -- https://code.claude.com/docs/en/permissions#read-and-edit
        tmp_dir = "./tmp",

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          custom_rules = {
            "scratch/custom_rules/",
          },

          --- Configure @file completion (all fields optional, sensible defaults)
          files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,            -- cap on total discovered files
            -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
          },

          source = "blink",
        },

        --- WARNING: if you change cwd then this is likely broken
        --- ill likely fix this in a later change
        md_files = {
          "AGENTS.md",
        },
      }

      -- take extra note that i have visual selection only in v mode
      -- technically whatever your last visual selection is, will be used
      -- so i have this set to visual mode so i dont screw up and use an
      -- old visual selection
      --
      -- likely ill add a mode check and assert on required visual mode
      -- so just prepare for it now
      vim.keymap.set("v", "<leader>av", function() _99.visual() end, { desc = "99 Visual Implementation" })

      --- if you have a request you dont want to make any changes, just cancel it
      vim.keymap.set("n", "<leader>ax", function() _99.stop_all_requests() end, { desc = "99 Stop All Requests" })

      vim.keymap.set("n", "<leader>as", function() _99.search() end, { desc = "99 Search" })
    end,
  },

  {
    "yetone/avante.nvim",
    enabled = false,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = "make BUILD_FROM_SOURCE=true",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      providers = {
        ---@type AvanteSupportedProvider
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-5-20250929",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "o4-mini-2025-04-16",
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          context_window = 128000, -- Number of tokens to send to the model for context
          extra_request_body = {
            temperature = 0.75,
            max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
          },
        },
        gemini = {
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
          model = "gemini-2.5-flash-preview-05-20",
          timeout = 30000, -- Timeout in milliseconds
          context_window = 1048576,
          use_ReAct_prompt = true,
          extra_request_body = {
            generationConfig = {
              temperature = 0.75,
            },
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
        -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
        "echasnovski/mini.icons",
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
      windows = {
        input = {
          height = 12,
        },
      },
    },
  },
}
