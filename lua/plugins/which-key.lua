return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 400 -- ms que espera antes de mostrar el panel
  end,
  opts = {
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>f", group = "buscar" },
      { "<leader>x", group = "diagnósticos" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Atajos del buffer actual",
    },
  },
}
