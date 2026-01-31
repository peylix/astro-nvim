local profile = require "profile"

---@type LazySpec
return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  enabled = profile.is_default, -- disable in reduced profile
  ft = { "tex", "plaintex", "bib" },
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "skim"
    -- Snacks integration
    vim.keymap.set("n", "<localleader>lt", function() return require("vimtex.snacks").toc() end)
  end,
}
