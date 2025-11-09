-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here


-- Move to the end of the line if this is the last line
vim.keymap.set( { "n", "x" }, "j", function()
  return vim.fn.line(".") == vim.fn.line("$") and "$" or "j"
end, { expr = true, noremap = true, desc = "Move to EOL on last line, else move down" })

-- Move to the beginning of the line if this is the first line
vim.keymap.set( { "n", "x" }, "k", function()
  return vim.fn.line(".") == 1 and "0" or "k"
end, { expr = true, noremap = true, desc = "Move to BOL on first line, else move up" })


-- Toggle wrap based on filetypes
local filetypes_to_wrap = {
  "markdown", "tex", "latex", "plaintex", "txt", "rst", "org",
  "asciidoc", "textile", "gitcommit", "mail"
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.tbl_contains(filetypes_to_wrap, vim.bo.filetype) then
      vim.opt_local.wrap = true
      vim.opt_local.linebreak = true
      vim.opt_local.breakindent = true
      vim.opt_local.showbreak = "↳ "
    else
      -- turn off wrap for other files
      vim.opt_local.wrap = false
    end
  end,
  group = vim.api.nvim_create_augroup("AutoWrap", { clear = true }),
  desc = "Auto wrap for text files only"
})

vim.o.list = true

vim.opt.listchars = {
  nbsp = '␣',      -- 不间断空格显示为 ␣ 符号
  -- trail = '•',     -- 行尾多余空格显示为 • 符号
  extends = '⟩',   -- 行内容超出右边界时显示 ⟩
  precedes = '⟨',  -- 行内容超出左边界时显示 ⟨
}

