---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "basedpyright",
        "bash-language-server",
        "css-lsp",
        "html-lsp",
        "rust-analyzer",
        "typescript-language-server",
        "markdown-oxide",
        "ruff",
        "clangd",

        -- install formatters
        "stylua",
        "clang-format",
        -- "isort",

        -- install linters
        "selene",

        -- install debuggers
        -- "debugpy",

        -- install any other package
        -- "tree-sitter-cli",
        "copilot-language-server",
      },
    },
  },
}
