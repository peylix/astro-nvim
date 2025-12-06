-- Language-specific word motion
-- Provides smart word motions for Chinese (jieba) and English (spider)

local M = {}

M.chinese_mode = false
M.jieba = nil -- Cache jieba module after first load

-- Set Chinese mode
function M.set_chinese_mode()
  M.chinese_mode = true
  -- Lazy load jieba when Chinese mode is activated
  if not M.jieba then
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
  vim.notify("Word motion mode: 汉语", vim.log.levels.INFO)
end

-- Set English mode
function M.set_english_mode()
  M.chinese_mode = false
  vim.notify("Word motion mode: English", vim.log.levels.INFO)
end

-- Obtain current mode
function M.get_mode() return M.chinese_mode and "chinese" or "english" end

-- Choose motion function smartly based on current mode
function M.lang_motion(motion_type)
  return function()
    if M.chinese_mode then
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
    else
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
      { "<leader>u[", M.set_chinese_mode, desc = "Set Chinese word motion" },
      { "<leader>u]", M.set_english_mode, desc = "Set English word motion" },
    },
  },
}
