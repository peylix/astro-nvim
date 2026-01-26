---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.clang_format.with {
        extra_args = function(params)
          local has_config = vim.fn.filereadable(params.root .. "/.clang-format") == 1
            or vim.fn.filereadable(vim.fn.expand "~/.clang-format") == 1
          if has_config then return {} end
          return { "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ColumnLimit: 100}" }
        end,
      },
    })
  end,
}
