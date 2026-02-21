local profile = require("profile")

---@type LazySpec
return {
  "chomosuke/typst-preview.nvim",
  -- lazy = false, -- or ft = 'typst'
  dependencies_bin = { ["tinymist"] = "tinymist" },
  enabled = profile.is_default, -- disable in reduced profile
  ft = { "typst" },
  version = "1.*",
  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
}
