local M = {}

local pnvim_profile = vim.env.PNVIM_PROFILE

M.name = (pnvim_profile == "reduced" or pnvim_profile == "default") and pnvim_profile
  or "default"
M.is_default = M.name == "default"
M.is_reduced = M.name == "reduced"

-- notify if it is in reduced mode
if M.is_reduced then
  vim.notify(
    "Neovim is running in reduced profile",
    vim.log.levels.WARN,
    { title = "Profile" }
  )
end

return M
