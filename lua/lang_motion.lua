-- Language-specific word motion
-- For Chinese I use jieba.nvim and for English nvim-spider

---@class LanguageMotion
local M = {}

M.chinese_mode = false

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

-- Set up keymaps for w/e/b/ge
function M.setup_keymaps()
  local keymap_opts = { noremap = true, silent = true }

  vim.keymap.set({ "n", "x", "o" }, "w", M.lang_motion "w", keymap_opts)
  vim.keymap.set({ "n", "x", "o" }, "e", M.lang_motion "e", keymap_opts)
  vim.keymap.set({ "n", "x", "o" }, "b", M.lang_motion "b", keymap_opts)
  vim.keymap.set({ "n", "x", "o" }, "ge", M.lang_motion "ge", keymap_opts)

  -- Mode toggle keymaps
  vim.keymap.set("n", "<leader>u[", M.set_chinese_mode, { noremap = true, silent = true, desc = "Set Chinese web motion" })
  vim.keymap.set("n", "<leader>u]", M.set_english_mode, { noremap = true, silent = true, desc = "Set English web motion" })
end

return M
