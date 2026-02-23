-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Configure Python provider to use uv-installed pynvim
-- This is for molten.nvim
-- vim.g.python3_host_prog = vim.fn.expand "~/.local/bin/pynvim-python"

-- Move to the end of the line if this is the last line
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.fn.line(".") == vim.fn.line("$") and "$" or "j"
end, { expr = true, noremap = true, desc = "Move to EOL on last line, else move down" })

-- Move to the beginning of the line if this is the first line
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.fn.line(".") == 1 and "0" or "k"
end, { expr = true, noremap = true, desc = "Move to BOL on first line, else move up" })

-- Remapping keybindings for moving to the end of line
vim.keymap.set({ "n", "x" }, "-", "$", { noremap = true, desc = "Move to end of line" })

-- show whitespace characters
vim.o.list = true

vim.opt.listchars = {
  nbsp = "␣", -- show non-breaking spaces as ␣
  -- trail = '•', -- show trailing spaces as •
  extends = "⟩", -- when line content exceeds right boundary, show ⟩
  precedes = "⟨", -- when line content exceeds left boundary, show ⟨
}

-- use xclip for clipboard on Linux
if vim.fn.has("linux") == 1 then vim.g.clipboard = "xclip" end
