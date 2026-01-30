local profile = require "profile"

local treesitter_default = {
  "lua",
  "vim",
  "python",
  "javascript",
  "typescript",
  "html",
  "css",
  "c",
  "bash",
  "json",
  "comment",
}

local treesitter_reduced = {
  "lua",
  "vim",
  "bash",
  "comment",
}

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = profile.is_reduced and treesitter_reduced or treesitter_default,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },
  },
}
