---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
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
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },

    indent = {
      enable = true
    },

  },
}
