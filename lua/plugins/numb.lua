return {
  'nacro90/numb.nvim',
  -- peeking the buffer while entering command `:{number}`
  config = function()
    require('numb').setup()
  end,
}
