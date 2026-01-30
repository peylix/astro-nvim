local M = {}
local nvim_profile = vim.env.NVIM_PROFILE
M.name = (nvim_profile == "reduced" or nvim_profile == "default") and nvim_profile or "default"
M.is_default = M.name == "default"
M.is_reduced = M.name == "reduced"
-- notify if it is in reduced mode
if M.is_reduced then
    vim.notify("Neovim is running in reduced profile mode", vim.log.levels.WARN, { title = "Profile" })
end
return M
