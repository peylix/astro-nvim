local M = {}
local nvim_profile = vim.env.NVIM_PROFILE
M.name = (nvim_profile == "reduced" or nvim_profile == "default") and nvim_profile or "default"
M.is_default = M.name == "default"
M.is_reduced = M.name == "reduced"
return M
