--return {
  --"nvim-lualine/lualine.nvim",
  --config = function()
    --require ('lualine').setup({
      --options = {
        --theme = 'dracula'
      --}
    --})
  --end
--}
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function() vim.opt.showmode = false end,
  opts = { options = { theme = "auto", globalstatus = true } },
}
