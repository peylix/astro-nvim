if not vim.g.vscode then return {} end

local plugins = {
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "flash.nvim",
  "nvim-spider",
  "yanky.nvim",
  "snack.nvim",
  "mini.nvim",
}

-- add macOS-specific plugin if and only if i am on macOS, though i am usually on it.
if vim.fn.has("mac") == 1 then table.insert(plugins, "im-select.nvim") end

local Config = require("lazy.core.config")
-- disable plugin update checking
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
-- replace the default `cond`
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(plugins, plugin.name)
end

---@type LazySpec
return {
  -- add a few keybindings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ff"] = "<CMD>Find<CR>",
          ["<Leader>fw"] = "<CMD>call VSCodeNotify('workbench.action.findInFiles')<CR>",
          ["<Leader>ls"] = "<CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
        },
      },
    },
  },
  -- disable colorscheme setting
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  -- disable treesitter highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
