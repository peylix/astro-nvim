-- Language-specific word motions
-- Provides smart word motions for Chinese (jieba) and English (spider)

local M = {}

M.current_mode = "english" -- Current mode: "english" | "chinese"
M.jieba = nil -- Cache jieba module after first load

-- Set mode (generic function)
function M.set_mode(mode)
  if mode ~= "english" and mode ~= "chinese" then
    vim.notify("Invalid mode: " .. mode, vim.log.levels.ERROR)
    return
  end

  M.current_mode = mode

  -- Lazy load jieba when Chinese mode is activated
  if mode == "chinese" and not M.jieba then
    -- Load the jieba plugin
    require("lazy").load({ plugins = { "jieba.nvim" } })
    local ok, jieba = pcall(require, "jieba_nvim")
    if ok then
      M.jieba = jieba
    else
      vim.notify("Failed to load jieba_nvim", vim.log.levels.ERROR)
      return
    end
  end

  local mode_names = { english = "English", chinese = "汉语" }
  vim.notify("Word motion mode: " .. mode_names[mode], vim.log.levels.INFO)
end

-- Convenience functions for mode switching
function M.set_chinese_mode()
  M.set_mode("chinese")
end

function M.set_english_mode()
  M.set_mode("english")
end

-- Obtain current mode
function M.get_mode()
  return M.current_mode
end

-- Choose motion function smartly based on current mode
function M.lang_motion(motion_type)
  return function()
    if M.current_mode == "chinese" then
      -- Chinese mode: use jieba.nvim (already loaded when mode was set)
      if M.jieba then
        local motion_func = M.jieba["wordmotion_" .. motion_type]
        if motion_func then
          motion_func()
        else
          vim.notify("Jieba motion not available: " .. motion_type, vim.log.levels.WARN)
        end
      else
        vim.notify("Jieba not loaded. Please toggle Chinese mode first.", vim.log.levels.WARN)
      end
    elseif M.current_mode == "english" then
      -- English mode: use nvim-spider
      local spider = require "spider"
      spider.motion(motion_type)
    end
  end
end

-- Plugin specifications
return {
  -- Chinese word segmentation
  {
    "noearc/jieba.nvim",
    enabled = false, -- something weird happens to jieba.nvim recently so disable it now.
    dependencies = { "noearc/jieba-lua" },
    lazy = true, -- Only load when Chinese mode is toggled
    opts = {
      use_default_mappings = false,
    },
  },

  -- English smart word motion
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      -- Set up keymaps for w/e/b/ge
      { "w", mode = { "n", "x", "o" }, M.lang_motion "w", desc = "Smart word motion: next word start" },
      { "e", mode = { "n", "x", "o" }, M.lang_motion "e", desc = "Smart word motion: next word end" },
      { "b", mode = { "n", "x", "o" }, M.lang_motion "b", desc = "Smart word motion: previous word start" },
      { "ge", mode = { "n", "x", "o" }, M.lang_motion "ge", desc = "Smart word motion: previous word end" },

      -- Mode toggle keymaps
      -- { "<leader>u[", M.set_chinese_mode, desc = "Set Chinese word motion" },
      -- { "<leader>u]", M.set_english_mode, desc = "Set English word motion" },
    },
  },
}
