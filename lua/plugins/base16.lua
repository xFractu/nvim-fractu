return {
  'RRethy/base16-nvim',
  priority = 1000,
  config = function()
    local ok, m = pcall(require, 'matugen')
    if ok then m.setup() end
  end,
}
