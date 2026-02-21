local profile = require("profile")
if profile.is_reduced then return {} end

---@type LazySpec
return {
  {
    -- NOTE: Run the following command every time updating this plugin:
    -- uv tool install --upgrade pynvim
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    ft = { "quarto", "qmd", "ipynb" },
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    cmd = {
      "MoltenInit",
      "MoltenEvaluateOperator",
      "MoltenEvaluateVisual",
      "MoltenReevaluateCell",
      "MoltenEnterOutput",
      "MoltenHideOutput",
      "MoltenDelete",
      "MoltenOpenInBrowser",
    },
    keys = {
      {
        "<localleader>e",
        "<cmd>MoltenEvaluateOperator<cr>",
        desc = "evaluate operator",
        silent = true,
      },
      {
        "<localleader>os",
        "<cmd>noautocmd MoltenEnterOutput<cr>",
        desc = "open output window",
        silent = true,
      },
      {
        "<localleader>rr",
        "<cmd>MoltenReevaluateCell<cr>",
        desc = "re-eval cell",
        silent = true,
      },
      {
        "<localleader>r",
        "<cmd>MoltenEvaluateVisual<cr>gv",
        mode = "v",
        desc = "execute visual selection",
        silent = true,
      },
      {
        "<localleader>oh",
        "<cmd>MoltenHideOutput<cr>",
        desc = "close output window",
        silent = true,
      },
      {
        "<localleader>md",
        "<cmd>MoltenDelete<cr>",
        desc = "delete Molten cell",
        silent = true,
      },
      {
        "<localleader>mx",
        "<cmd>MoltenOpenInBrowser<cr>",
        desc = "open output in browser",
        silent = true,
      },
    },
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_init_behavior = "init"
      vim.g.molten_enter_output_behavior = "open_and_enter"
      vim.g.molten_auto_image_popup = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_crop_border = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_output_win_style = "minimal"
      vim.g.molten_output_win_hide_on_leave = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 10000
      vim.g.molten_cover_empty_lines = false
      vim.g.molten_copy_output = true
      vim.g.molten_output_show_exec_time = false
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    ft = { "quarto", "qmd", "ipynb" },
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    ft = { "quarto", "qmd", "markdown" },
    event = { "BufReadPre *.ipynb", "BufNewFile *.ipynb" },
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        custom_language_formatting = {
          python = {
            extension = "md",
            style = "markdown",
            force_ft = "markdown",
          },
        },
        force_ft = nil, -- Don't force filetype, let Neovim detect it
      })
    end,
  },
  {
    "jmbuhr/otter.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      verbose = { no_code_found = false },
    },
    config = function(_, opts)
      local otter = require("otter")
      otter.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(args)
          local name = vim.api.nvim_buf_get_name(args.buf)
          if name:match("%.ipynb$") then otter.activate(nil, true, true) end
        end,
      })
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "qmd" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
        ft_runners = { python = "molten" },
        never_run = { "yaml" },
      },
    },
  },
}
