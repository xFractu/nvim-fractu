return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Errores de todo el proyecto" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Errores del archivo actual" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Lista quickfix" },
  },
}
